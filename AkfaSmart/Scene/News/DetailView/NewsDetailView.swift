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
import UIKit

struct NewsDetailView: View {
    let itemModel: NewsItemViewModel
    @ObservedObject var output: ImageDownloaderViewModel.Output
    var navigationController: UINavigationController

    private let getImageTrigger = PassthroughSubject<String, Never>()
    private let cancelBag = CancelBag()

    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(title: "NEWS".localizedString) {
                navigationController.popViewController(animated: true)
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if let data = output.imageData {
                        Image(data: data)?
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text(itemModel.title ?? "")
                            .font(.headline)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                        Text(itemModel.shortContent ?? "")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                        Text(Date(timeIntervalSince1970: TimeInterval(itemModel.date ?? 1) / 1000.0).convertToDateUS())
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "#9DA8C2"))
                            .padding(6)
                            .background(Color(hex: "#F7F7F6"))
                            .cornerRadius(6)
                        if let htmlContent = itemModel.htmlContent {
                            WebView(html: htmlContent)
                                .frame(height: UIScreen.main.bounds.height * 0.6)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            getImageTrigger.send(itemModel.imageUrl ?? "")
        }
    }

    init(itemModel: NewsItemViewModel, navigationController: UINavigationController) {
        self.itemModel = itemModel
        let input = ImageDownloaderViewModel.Input(getImageTrigger: getImageTrigger.asDriver())
        self.output = ImageDownloaderViewModel().transform(input, cancelBag: cancelBag)
        self.navigationController = navigationController
    }
}


struct WebView: UIViewRepresentable {
    let html: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.backgroundColor = UIColor.clear
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.loadHTMLString(addStyleToHTML(html), baseURL: nil)
    }

    private func addStyleToHTML(_ html: String) -> String {
        let css = """
            body { width: 100%; max-width: 100%; }
            img { max-width: 100%; height: auto; }
        """
        if let range = html.range(of: "<head>") {
            var result = html
            result.insert(contentsOf: "<style>\(css)</style>", at: range.upperBound)
            return result
        }
        return "<style>\(css)</style>" + html
    }
}
