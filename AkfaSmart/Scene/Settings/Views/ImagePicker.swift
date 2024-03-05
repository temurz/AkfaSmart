//
//  CameraView.swift
//  AkfaSmart
//
//  Created by Temur on 05/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: Data?
    @Environment(\.presentationMode) var isPresented
    var dismiss: (() -> Void)?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
            return Coordinator(picker: self)
        }
}


class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePicker
    
    init(picker: ImagePicker) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage.jpegData(compressionQuality: 0.5)
        self.picker.isPresented.wrappedValue.dismiss()
        self.picker.dismiss?()
    }
}

enum PickerImage {
    enum Source: String {
        case library, camera
    }
    
    static func checkPermissions(_ source: Source) -> Bool {
        switch source {
        case .library:
            return UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        case .camera:
            return UIImagePickerController.isSourceTypeAvailable(.camera)
        }
    }
}
