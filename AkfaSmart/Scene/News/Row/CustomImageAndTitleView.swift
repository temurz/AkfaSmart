//
//  CustomCellView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct CustomImageAndTitleView: View {
    let urlString: String
    let title: String
    let shortContent: String
    var body: some View {
        if let url = URL(string: urlString) {
            Group {
                
                if #available(iOS 15.0, *) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .padding()
                    } placeholder: {
                        ShimmerView()
                            .cornerRadius(16)
                    }
                    .frame(height: 200)
                    .padding(.top)
                } else {
                    
                    AsyncImageEarly(
                        url: url,
                        placeholder: { ProgressView() },
                        image: { image in
                            ((Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                            ) as! Image)
                        }
                    )
                    .frame(height: 200)
                    .padding(.top)
                }
                
                
                Text(title )
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Text(shortContent)
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
        }
    }
}
