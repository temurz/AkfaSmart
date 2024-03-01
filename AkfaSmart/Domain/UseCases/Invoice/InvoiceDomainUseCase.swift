//
//  InvoiceDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol InvoiceDomainUseCase {
    var gateway: InvoiceListGatewayType { get }
}

extension InvoiceDomainUseCase {
    func getInvoiceList(input: InvoiceInput, page: Int) -> Observable<PagingInfo<Invoice>> {
        let dto = GetPageDto(page: page)
        return gateway.getInvoiceList(input: input, dto: dto)
    }
}
