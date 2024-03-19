//
//  DownloadTaskModel.swift
//  AkfaSmart
//
//  Created by Temur on 15/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
class DownloadTaskModel: NSObject, ObservableObject, URLSessionDownloadDelegate, UIDocumentInteractionControllerDelegate {
    @Published var donwloadTaskURL: URL!
    
    @Published var alertMsg = ""
    @Published var showAlert = false
    
    //Savind download task reference for cancelling
    @Published var downloadTaskSession: URLSessionDownloadTask!
    
    //Progress
    @Published var downloadProgress: CGFloat = 0
    
    //Show Progress View...
    @Published var showDownloadProgress = false
    
    var counter = 0.0
    
    func startDownload(urlString: String) {
        //checking valid URL
        
        
        guard let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let validURL = URL(string: encodedURLString) else {
            self.reportError(error: "Invalid URL !!!")
            return
        }
        
        let directoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        if /*FileManager.default.fileExists(atPath: directoryPath.appendingPathComponent(validURL.lastPathComponent).path)*/ false {
            print("yes file found")
            
            let controller = UIDocumentInteractionController(url: directoryPath.appendingPathComponent(validURL.lastPathComponent))
            controller.delegate = self
            controller.presentPreview(animated: true)
        }else {
            print("no file found")
            
            //valid URL...
            downloadProgress = 0
            withAnimation {
                 showDownloadProgress = true
            }
            
            // Create a URLRequest with the given URL
            var request = URLRequest(url: validURL)

            // Add the bearer token to the request's Authorization header
            let bearerToken = AuthApp.shared.token ?? ""
            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
            
            //Download task
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            
            downloadTaskSession = session.downloadTask(with: request)
            downloadTaskSession.resume()
        }
        
    }
    
    func reportError(error: String) {
        alertMsg = error
        showAlert.toggle()
    }
    
    //Implementation URLSession Functions ...
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let url = downloadTask.originalRequest?.url else {
            DispatchQueue.main.async {
                self.reportError(error: "Something went wrong please try again late")
            }
            return
        }
        let directoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let destinationURL = directoryPath.appendingPathComponent(url.lastPathComponent)
        
        try? FileManager.default.removeItem(at: destinationURL)
        
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            
            DispatchQueue.main.async {
                withAnimation {
                    self.showDownloadProgress = false
                    
                    let controller = UIDocumentInteractionController(url: destinationURL)
                    controller.delegate = self
                    controller.presentPreview(animated: true)
                }
            }
            
        }
        catch {
            DispatchQueue.main.async {
                self.reportError(error: "Please try again later !!!")
            }
        }
        
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        //getting progress
        let newTotal = totalBytesExpectedToWrite == -1 ? 400 : totalBytesExpectedToWrite
        var progress = CGFloat(totalBytesWritten) / CGFloat(newTotal)
        progress = totalBytesExpectedToWrite == -1 ? progress / 100000 : progress
        
        if totalBytesExpectedToWrite == -1 {
            progress = counter
            counter += 0.0005
        }
        
        print(progress)
        DispatchQueue.main.async {
            self.downloadProgress = progress
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async {
            if let error = error {
                withAnimation {
                    self.showDownloadProgress = false
                }
                self.reportError(error: error.localizedDescription)
                return
            }
        }
        
    }
    
    func cancelTask() {
        if let task = downloadTaskSession, task.state == .running {
            downloadTaskSession.cancel()
            withAnimation {
                self.showDownloadProgress = false
            }
        }
    }
    
    // Sub functions for presenting view
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return UIApplication.shared.windows.first!.rootViewController!
    }
}
