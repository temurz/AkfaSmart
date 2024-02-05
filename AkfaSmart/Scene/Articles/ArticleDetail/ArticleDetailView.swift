//
//  ArticleDetailView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct ArticleDetailView: View {
    let viewModel: ArticleItemViewModel
    var body: some View {
        VStack(alignment: .leading) {
            CustomImageAndTitleView(urlString: viewModel.imageUrl ?? "", title: viewModel.title ?? "", shortContent: viewModel.shortContent ?? "")
                .padding(.horizontal)
            Divider()
            if let htmlContent = viewModel.htmlContent {
                WebView(html: htmlContent)
            }
        }
    }
}

#Preview {
    ArticleDetailView(viewModel: ArticleItemViewModel(id: 0, date: nil, title: nil, shortContent: nil, htmlContent: nil, imageUrl: nil, type: nil, buttonColor: nil, fileUrls: nil))
}
