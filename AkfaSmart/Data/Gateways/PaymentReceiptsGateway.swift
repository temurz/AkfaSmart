//
//  PaymentReceiptsGateway.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol PaymentReceiptsGatewayType {
    func getPaymentReceiptList(input: ReceiptsInput, dto: GetPageDto) -> Observable<PagingInfo<PaymentReceipt>>
}

struct PaymentReceiptsGateway: PaymentReceiptsGatewayType {
    func getPaymentReceiptList(input: ReceiptsInput, dto: GetPageDto) -> Observable<PagingInfo<PaymentReceipt>> {
        let input = API.GetPaymentReceiptsAPIInput(input: input, dto: dto)
        return API.shared.getPaymentReceiptList(input)
            .tryMap { receipts in
                return receipts
            }
            .replaceNil(with: [])
            .map { PagingInfo(page: dto.page, items: $0, hasMorePages: $0.count == dto.perPage )}
            .eraseToAnyPublisher()
    }
}
