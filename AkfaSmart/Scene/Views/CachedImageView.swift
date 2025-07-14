//
//  ImageCache.swift
//  AkfaSmart
//
//  Created by Temur on 14/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//


import SwiftUI

class NewImageCache {
    static let shared = NSCache<NSURL, UIImage>()
}

struct CachedImageView: View {
    let urlString: String
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    var placeholder: Image?

    @State private var uiImage: UIImage?
    @State private var loadFailed = false

    var body: some View {
        VStack {
            if let image = uiImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if loadFailed {
                if let placeholder {
                    placeholder
                        .resizable()
                        .scaledToFill()
                } else {
                    Color.clear
                }
            } else {
                ProgressView()
                    
            }
        }
        .frame(width: width, height: height)
        .cornerRadius(cornerRadius, corners: .allCorners)
        .onAppear(perform: loadImage)
    }

    private func loadImage() {
        guard let url = URL(string: urlString) else {
            loadFailed = true
            return
        }
        
        if let cached = NewImageCache.shared.object(forKey: url as NSURL) {
            self.uiImage = cached
            return
        }

        var request = URLRequest(url: url)
        if let token = AuthApp.shared.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data, let image = UIImage(data: data) {
                NewImageCache.shared.setObject(image, forKey: url as NSURL)
                DispatchQueue.main.async {
                    self.uiImage = image
                    self.loadFailed = false
                }
            } else {
                DispatchQueue.main.async {
                    self.loadFailed = true
                }
            }
        }.resume()
    }
}
