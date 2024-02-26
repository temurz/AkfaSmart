//
//  ArticleDetailView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct ArticleDetailView: View {
    let itemModel: ArticleItemViewModel
    @ObservedObject var output: ImageDownloaderViewModel.Output
    
    private let getImageTrigger = PassthroughSubject<String,Never>()
    private let cancelBag = CancelBag()
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                if let data = output.imageData {
                    CustomImageAndTitleView(data: data)
                }
                Text(itemModel.title ?? "")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding(.top)
                Text(itemModel.shortContent ?? "")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
            .padding(.horizontal)
            Divider()
            if let htmlContent = itemModel.htmlContent {
                WebView(html: htmlContent)
            }
        }
        .onAppear {
            getImageTrigger.send(itemModel.imageUrl ?? "")
        }
    }
    
    init(itemModel: ArticleItemViewModel) {
        self.itemModel = itemModel
        let input = ImageDownloaderViewModel.Input(getImageTrigger: getImageTrigger.asDriver())
        self.output = ImageDownloaderViewModel().transform(input, cancelBag: cancelBag)
    }
}

#Preview {
    ArticleDetailView(itemModel: ArticleItemViewModel(id: 0, date: nil, title: nil, shortContent: nil, htmlContent: nil, imageUrl: nil, type: nil, buttonColor: nil, fileUrls: nil))
}
