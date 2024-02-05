//
//  NewsDetailView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import WebKit
struct NewsDetailView: View {
    let viewModel: NewsItemViewModel
    var body: some View {
        return LoadingView(isShowing: .constant(false), text: .constant("")) {
            VStack(alignment: .leading) {
                CustomImageAndTitleView(urlString: viewModel.imageUrl ?? "", title: viewModel.title ?? "", shortContent: viewModel.shortContent ?? "")
                
                Text(viewModel.date ?? "")
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "#9DA8C2"))
                    .padding(6)
                    .background(Color.init(hex: "#F7F7F6"))
                    .cornerRadius(6)
                
                if let htmlContent = viewModel.htmlContent {
                    WebView(html: htmlContent)
                }
                
            }
            .padding()
        }
        .navigationTitle("News")
    }
}


struct WebView: UIViewRepresentable {
    // 1
    let html: String

    
    // 2
    func makeUIView(context: Context) -> WKWebView {

        return WKWebView()
    }
    
    // 3
    func updateUIView(_ webView: WKWebView, context: Context) {

        let headString = "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head>"
        webView.loadHTMLString(headString + html, baseURL: nil)
    }
}
