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
    
    private let getImageTrigger = PassthroughSubject<String,Never>()
    
    private let cancelBag = CancelBag()
    
    var body: some View {
        VStack {
            CustomNavigationBar(title: "NEWS".localizedString) {
                navigationController.popViewController(animated: true)
            }
            VStack {
                if let data = output.imageData {
                    Image(data: data)?
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 64)
                        .frame(height: 200)
                        .scaledToFill()
                        .cornerRadius(12)
                        .padding()
                }
            }
            VStack(alignment: .leading) {
                
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
                Text(Date(timeIntervalSince1970: TimeInterval(itemModel.date ?? 1)/1000.0).convertToDateUS())
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
    
    // 3
    func updateUIView(_ webView: WKWebView, context: Context) {
        let styledHTML = addStyleToHTML(html)
        //        let headString = "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head>"
//        let headString = "<head><meta name='viewport' content='width=device-width, shrink-to-fit=YES'></head>"
//        let modifiedHTMLContent = html.replacingOccurrences(of: "<head>.*?</head>", with: headString, options: .regularExpression, range: nil)

        webView.loadHTMLString(styledHTML, baseURL: nil)
    }
    
    private func addStyleToHTML(_ html: String) -> String {
        let css = """
                body {
                    width: 100%;
                    max-width: 100%;
                }
                img {
                    max-width: 100%;
                    height: auto;
                }
            """
        // Find the <head> tag and insert the <style> tag containing the CSS
        if let range = html.range(of: "<head>") {
            var styledHTML = html
            styledHTML.insert(contentsOf: "<style>\(css)</style>", at: range.upperBound)
            return styledHTML
        } else {
            // If <head> tag is not found, simply append the <style> tag to the beginning of the HTML content
            return "<style>\(css)</style>" + html
        }
    }
}
