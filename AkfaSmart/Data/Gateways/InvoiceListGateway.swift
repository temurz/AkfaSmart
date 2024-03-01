//
//  InvoiceListGateway.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol InvoiceListGatewayType {
    func getInvoiceList(input: InvoiceInput, dto: GetPageDto) -> Observable<PagingInfo<Invoice>>
}

struct InvoiceListGateway: InvoiceListGatewayType {
    func getInvoiceList(input: InvoiceInput, dto: GetPageDto) -> Observable<PagingInfo<Invoice>> {
        let input = API.GetInvoiceListInput(input: input, dto: dto)
        return API.shared.getInvoiceList(input)
            .map { output -> [Invoice] in
                return output
            }
            .replaceNil(with: [])
            .map { PagingInfo(page: dto.page, items: $0, hasMorePages: $0.count == dto.perPage)}
            .eraseToAnyPublisher()
    }
}
