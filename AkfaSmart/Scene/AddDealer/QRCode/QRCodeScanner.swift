//
//  QRCodeScanner.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import SwiftUI
import AVFoundation
struct QRCodeScannerViewMain: View {
    @Binding var result: String
    @Environment(\.dismiss) var dismiss
    @State var isTorchOn: Bool = false
    var body: some View {
        // Create a QR code scanner view
        
        ZStack {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized || !UserDefaults.standard.bool(forKey: "askedCameraAccess") {
                QRCodeScanner(result: $result) {
                    dismiss()
                }
                .torchLight(isOn: isTorchOn)
                .interval(delay: 1.0)
            }else {
                VStack {
                    Text("NEED_CAMERA_ALLOW".localizedString)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button("OPEN_SETTINGS".localizedString) {
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(settingsURL)
                        }
                    }
                }
            }
                
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Text("DISMISS".localizedString)
                            .padding(4)
                    }
                    
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isTorchOn.toggle()
                    }, label: {
                        Image(systemName: self.isTorchOn ? "bolt.fill" : "bolt.slash.fill")
                            .imageScale(.large)
                            .foregroundColor(self.isTorchOn ? Color.yellow : Color.blue)
                            .padding()
                    })
                    .background(.white)
                    .cornerRadius(12)
                    .padding(.bottom)
                    Spacer()
                }
            }.padding()
            
            
        }
        .ignoresSafeArea(.all)
    }
}

struct QRCodeScanner: UIViewControllerRepresentable {
    @Binding var result: String
    var onFound: (() -> Void)
    
    private let delegate = QrCodeCameraDelegate()
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<QRCodeScanner>) -> UIViewController {
        // Create a QR code scanner
        let scannerViewController = QRCodeScannerViewController($result, onFound: onFound)
        return scannerViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<QRCodeScanner>) {
        // Update the view controller
    }
    
    func torchLight(isOn: Bool) -> QRCodeScanner {
        if let backCamera = AVCaptureDevice.default(for: AVMediaType.video) {
            if backCamera.hasTorch {
                try? backCamera.lockForConfiguration()
                if isOn {
                    backCamera.torchMode = .on
                } else {
                    backCamera.torchMode = .off
                }
                backCamera.unlockForConfiguration()
            }
        }
        return self
    }
    
    func interval(delay: Double) -> QRCodeScanner {
        delegate.scanInterval = delay
        return self
    }
}

class QRCodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    // Set up the camera and capture session
    let captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    @Binding var scanResult: String
    var onFound: (() -> Void)?
    
    init(_ scanResult: Binding<String>, onFound: @escaping () -> Void) {
        self._scanResult = scanResult
        self.onFound = onFound
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the capture session
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Failed to get the camera device")
            return
        }
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            // Already Authorized
            setCamera(captureDevice)
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self] (granted: Bool) -> Void in
                guard let self else { return }
                UserDefaults.standard.setValue(true, forKey: "askedCameraAccess")
               if granted {
                   // User granted
                   self.setCamera(captureDevice)
               } else {
                   // User rejected
                   return
               }
           })
        }
        
        
    }
    
    private func setCamera(_ captureDevice: AVCaptureDevice) {
        let input = try? AVCaptureDeviceInput(device: captureDevice)
        self.captureSession.addInput(input!)
        
        // Set up the metadata output
        let captureMetadataOutput = AVCaptureMetadataOutput()
        self.captureSession.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        // Start the capture session
        self.videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadata object contains a QR code
        if metadataObjects.count == 0 {
            return
        }
        
        // Get the first metadata object
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        // Check if the QR code contains a valid URL
        if metadataObj.type == AVMetadataObject.ObjectType.qr, let qrCodeString = metadataObj.stringValue {
            self.scanResult = qrCodeString
            self.onFound?()
        }
    }
}
