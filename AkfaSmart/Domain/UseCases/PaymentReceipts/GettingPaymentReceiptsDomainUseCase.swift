//
//  GettingPaymentReceiptsDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol GettingPaymentReceiptsDomainUseCase {
    var gateway: PaymentReceiptsGatewayType { get }
}

extension GettingPaymentReceiptsDomainUseCase {
    func getPaymentReceiptList(input: ReceiptsInput, page: Int) -> Observable<PagingInfo<PaymentReceipt>> {
        let dto = GetPageDto(page: page)
        return gateway.getPaymentReceiptList(input: input, dto: dto)
    }
}
