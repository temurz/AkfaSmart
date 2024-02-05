//
//  AsyncImageEarly.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import SwiftUI

struct AsyncImageEarly<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
     private let placeholder: Placeholder
     private let image: (UIImage) -> Image
     
     init(
         url: URL,
         @ViewBuilder placeholder: () -> Placeholder,
         @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
     ) {
         self.placeholder = placeholder()
         self.image = image
         _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
     }
     
     var body: some View {
         content
             .onAppear(perform: loader.load)
     }
     
     private var content: some View {
         Group {
             if loader.image != nil {
                 image(loader.image!)
                     .aspectRatio(contentMode: .fit)
             } else {
                 placeholder
             }
         }
     }
}
