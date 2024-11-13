//
//  GettingInvoiceDetailDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol GettingInvoiceDetailDomainUseCase {
    var gateway: InvoiceDetailGatewayType { get }
}

extension GettingInvoiceDetailDomainUseCase {
    func getInvoiceDetail(invoiceId: Int, dealerId: Int) -> Observable<[InvoiceDetail]> {
        gateway.getInvoiceDetail(invoiceId: invoiceId, dealerId: dealerId)
    }
    
    func getInvoiceElectronCheque(invoiceId: Int, dealerId: Int) -> Observable<String> {
        gateway.getInvoiceElectronCheque(invoiceId: invoiceId, dealerId: dealerId)
    }
}
