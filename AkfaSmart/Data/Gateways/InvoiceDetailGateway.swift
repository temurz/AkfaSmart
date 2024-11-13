//
//  InvoiceDetailGateway.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol InvoiceDetailGatewayType {
    func getInvoiceDetail(invoiceId: Int, dealerId: Int) -> Observable<[InvoiceDetail]>
    func getInvoiceElectronCheque(invoiceId: Int, dealerId: Int) -> Observable<String>
}

struct InvoiceDetailGateway: InvoiceDetailGatewayType {
    func getInvoiceDetail(invoiceId: Int, dealerId: Int) -> Observable<[InvoiceDetail]> {
        let input = API.GetInvoiceDetailAPIInput(invoiceId: invoiceId, dealerId: dealerId)
        return API.shared.getInvoiceDetail(input)
    }
    
    func getInvoiceElectronCheque(invoiceId: Int, dealerId: Int) -> Observable<String> {
        let input = API.GetInvoiceElectronChequeAPIInput(invoiceId: invoiceId, dealerId: dealerId)
        return API.shared.getInvoiceElectronCheque(input)
    }

}
