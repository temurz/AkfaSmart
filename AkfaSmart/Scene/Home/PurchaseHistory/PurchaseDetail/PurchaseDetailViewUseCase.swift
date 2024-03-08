//
//  PurchaseDetailViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol PurchaseDetailViewUseCaseType {
    func getInvoiceDetail(invoiceId: Int, dealerId: Int) -> Observable<[InvoiceDetail]>
}

struct PurchaseDetailViewUseCase: PurchaseDetailViewUseCaseType, GettingInvoiceDetailDomainUseCase {
    var gateway: InvoiceDetailGatewayType
}
