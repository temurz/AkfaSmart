//
//  PurchaseDetailViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import UIKit
struct PurchaseDetailViewModel {
    let useCase: PurchaseDetailViewUseCaseType
    let navigator: PopViewNavigatorType
}

extension PurchaseDetailViewModel: ViewModel {
    struct Input {
        let loadDetailsTrigger: Driver<InvoiceDetailViewInput>
        let popViewController: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var items: [InvoiceDetail] = []
        @Published var html: String? = nil
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
//        input.loadDetailsTrigger
//            .sink { input in
//            useCase.getInvoiceDetail(invoiceId: input.invoiceId, dealerId: input.dealerId)
//                .trackError(errorTracker)
//                .trackActivity(activityTracker)
//                .asDriver()
//                .sink { detailItems in
//                    output.items = detailItems
//                }
//                .store(in: cancelBag)
//            }
//            .store(in: cancelBag)
        
        input.loadDetailsTrigger
            .sink { input in
                useCase.getInvoiceElectronCheque(invoiceId: input.invoiceId, dealerId: input.dealerId)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { html in
                        
                            var modified = html.replacingOccurrences(of: "XARIDINGIZ UCHUN RAHMAT!", with: "")
//                            modified = addStyleToHTML(modified)
                            output.html = modified
                        
                    }
                    .store(in: cancelBag)
            }
            
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        input.popViewController
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)
        
        return output
    }
    
    private func makeHtml(_ html: String) -> String {
//        let headString = "<head><meta name='viewport' content='width=device-width, initial-scale=2.3, shrink-to-fit=YES, maximum-scale=10, user-scalable=no'></head>"
//        let modifiedHTMLContent = html.replacingOccurrences(of: "<head>.*?</head>", with: headString, options: .regularExpression, range: nil)
        
        let viewportMeta = """
            <meta name='viewport' content='width=device-width, initial-scale=0, maximum-scale=1, user-scalable=no'>
        """

        var modifiedHtmlContent = html
//
//        // Check if the HTML has a <head> section
        if let headRange = modifiedHtmlContent.range(of: "</head>") {
            // Insert the viewport meta tag before the </head> tag
            modifiedHtmlContent.insert(contentsOf: viewportMeta, at: headRange.lowerBound)
        } else {
            // If there's no <head> tag, create one and add it at the start of the HTML content
            modifiedHtmlContent = "<head>\(viewportMeta)</head>" + modifiedHtmlContent
        }

        return modifiedHtmlContent
    }


    
    private func addStyleToHTML(_ html: String) -> String {
        let css = """
            body {
                width: 100%;
                max-width: 100%;
                max-height: auto;
                overflow-x: hidden;
                margin: 0;
                padding: 0;
            }
            * {
                width: 100% !important;
                max-width: 100% !important;
                box-sizing: border-box; /* Ensures padding and borders are included in total width */
            }
        
            img {
                width: auto;
                height: auto;
                max-width: 100%;
                max-height: auto;
            }
            table, td, th {
                    font-size: 12px;
                    width: 100% !important;
                    max-width: 100% !important;
                    max-height: auto;
                    table-layout: auto; /* Use auto layout for better flexibility */
            }
            .jrPage, .someClassWithFixedWidth {
                    width: 100% !important;
                    max-width: 100% !important;
                    box-sizing: border-box;
                }

            *[style*="width:"] {
                    width: 100% !important;
                    max-width: 100% !important;
            }
            @media (max-width: 600px) {
                    body {
                        font-size: 14px; /* Scale down for smaller screens */
                    }
                }
            p, h1, h2, h3, h4, h5, h6 {
                    margin: 0;
            }
        """
        let viewportMetaTag = """
            <meta name="viewport" content="width=device-width, initial-scale=0, maximum-scale=1, user-scalable=no"/>
        """

        if let range = html.range(of: "<head>") {
            var styledHTML = html
            styledHTML.insert(contentsOf: "\(viewportMetaTag)<style>\(css)</style>", at: range.upperBound)
            return styledHTML
        } else {
            return "\(viewportMetaTag)<style>\(css)</style>" + html
        }

    }
}

struct InvoiceDetailViewInput {
    let invoiceId: Int
    let dealerId: Int
}
