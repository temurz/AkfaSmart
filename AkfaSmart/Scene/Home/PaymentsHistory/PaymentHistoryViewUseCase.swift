//
//  PaymentHistoryViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol PaymentHistoryViewUseCaseType {
    func getPaymentReceiptList(input: ReceiptsInput, page: Int) -> Observable<PagingInfo<PaymentReceipt>>
}

struct PaymentHistoryViewUseCase: PaymentHistoryViewUseCaseType, GettingPaymentReceiptsDomainUseCase {
    var gateway: PaymentReceiptsGatewayType
}
