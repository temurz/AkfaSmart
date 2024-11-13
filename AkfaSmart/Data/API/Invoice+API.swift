//
//  Invoice+API.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Alamofire
extension API {
    func getInvoiceList(_ input: GetInvoiceListInput) -> Observable<[Invoice]> {
        requestList(input)
    }
    
    final class GetInvoiceListInput: APIInput {
        init(input: InvoiceInput, dto: GetPageDto) {
            var params: Parameters = [
                "type": input.type,
                "length": dto.perPage,
                "start": dto.page
            ]
            if let from = input.from {
                params["from"] = from.toShortFormat()
            }
            if let to = input.to {
                params["to"] = to.toShortFormat()
            }
            
            super.init(urlString: API.Urls.getInvoiceList, parameters: params, method: .post, requireAccessToken: true)
        }
    }
}

extension API {
    func getInvoiceDetail(_ input: GetInvoiceDetailAPIInput) -> Observable<[InvoiceDetail]> {
        requestList(input)
    }
    
    final class GetInvoiceDetailAPIInput: APIInput {
        init(invoiceId: Int, dealerId: Int) {
            let url = API.Urls.getInvoiceListById + "/\(invoiceId)/\(dealerId)"
            super.init(urlString: url, parameters: nil, method: .post, requireAccessToken: true)
        }
    }
}

extension API {
    func getInvoiceElectronCheque(_ input: GetInvoiceElectronChequeAPIInput) -> Observable<String> {
        requestPrimitive(input)
    }
    
    final class GetInvoiceElectronChequeAPIInput: APIInput {
        init(invoiceId: Int, dealerId: Int) {
            let parameters: Parameters = [
                "invoiceCid": invoiceId,
                "dealerId": dealerId
            ]
            
            super.init(urlString: API.Urls.getInvoiceElectronCheque, parameters: parameters, method: .get, requireAccessToken: true)
        }
    }
}
