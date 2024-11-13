//
//  PurchaseDetailView.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import WebKit
struct PurchaseDetailView: View {
    var model: Invoice
    @ObservedObject var output: PurchaseDetailViewModel.Output
    private let loadDetailsTrigger = PassthroughSubject<InvoiceDetailViewInput, Never>()
    private let popViewControllerTrigger = PassthroughSubject<Void, Never>()
    private let cancelBag = CancelBag()

    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "\(model.cid ?? 0)") {
                    popViewControllerTrigger.send(())
                }
//                List {
//                    ForEach(output.items, id: \.uniqueId) { item in
//                        PurchaseDetailViewRow(model: item)
//                    }
//                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//                }
//                .listStyle(.plain)
                if let html = output.html {
                    InvoiceWebView(html: html)
                } else {
                    Color.white
                }
            }
        }
        .onAppear {
            loadDetailsTrigger.send(InvoiceDetailViewInput(invoiceId: model.cid ?? 0, dealerId: model.dealerId ?? 0))
        }
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    init(model: Invoice, viewModel: PurchaseDetailViewModel) {
        self.model = model
        let input = PurchaseDetailViewModel.Input(
            loadDetailsTrigger: loadDetailsTrigger.asDriver(),
            popViewController: popViewControllerTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}


struct InvoiceWebView: UIViewRepresentable {
    let html: String
    
    
    func makeUIView(context: Context) -> WKWebView {
        let jsToRemoveWidth = """
        (function() {
            // Remove width attributes from all elements
            let elements = document.querySelectorAll('*[width]');
            elements.forEach((el) => el.removeAttribute('width'));

            // Set all tables to 100% width
            let tables = document.querySelectorAll('table');
            tables.forEach((table) => table.style.width = '100%');
        })();
        """
        
        let config = WKWebViewConfiguration()
        config.userContentController.addUserScript(WKUserScript(source: jsToRemoveWidth, injectionTime: .atDocumentEnd, forMainFrameOnly: true))
        return WKWebView(frame: .zero, configuration: config)
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.scrollView.showsVerticalScrollIndicator = false
        
        webView.loadHTMLString(html, baseURL: nil)
    }
}
