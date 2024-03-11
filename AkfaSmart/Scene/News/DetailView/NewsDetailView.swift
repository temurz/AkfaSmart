//
//  NewsDetailView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import WebKit
import Combine
struct NewsDetailView: View {
    let itemModel: NewsItemViewModel
    @ObservedObject var output: ImageDownloaderViewModel.Output
    
    private let getImageTrigger = PassthroughSubject<String,Never>()
    private let cancelBag = CancelBag()
    
    var body: some View {
        return LoadingView(isShowing: .constant(false), text: .constant("")) {
            VStack(alignment: .leading) {
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
                
                Text(itemModel.date?.convertToDateUS() ?? "")
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "#9DA8C2"))
                    .padding(6)
                    .background(Color.init(hex: "#F7F7F6"))
                    .cornerRadius(6)
                
                if let htmlContent = itemModel.htmlContent {
                    WebView(html: htmlContent)
                }
                
            }
            .padding()
        }
        .navigationTitle("NEWS".localizedString)
        .onAppear {
            getImageTrigger.send(itemModel.imageUrl ?? "")
        }
    }
    
    init(itemModel: NewsItemViewModel) {
        self.itemModel = itemModel
        let input = ImageDownloaderViewModel.Input(getImageTrigger: getImageTrigger.asDriver())
        self.output = ImageDownloaderViewModel().transform(input, cancelBag: cancelBag)
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
