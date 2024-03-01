//
//  PurchaseHistoryViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation

protocol PurchaseHistoryViewUseCaseType {
    func getInvoiceList(input: InvoiceInput, page: Int) -> Observable<PagingInfo<Invoice>>
}

struct PurchaseHistoryViewUseCase: PurchaseHistoryViewUseCaseType, InvoiceDomainUseCase {
    var gateway: InvoiceListGatewayType
}

struct InvoiceInput {
    let from: Date?
    let to: Date?
    let type: String
}
