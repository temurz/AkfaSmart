//
//  Payments+API.swift
//  AkfaSmart
//
//  Created by Temur on 07/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Alamofire
extension API {
    func getPaymentReceiptList(_ input: GetPaymentReceiptsAPIInput) -> Observable<[PaymentReceipt]> {
        requestList(input)
    }
    
    final class GetPaymentReceiptsAPIInput: APIInput {
        init(input: ReceiptsInput, dto: GetPageDto ) {
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
            super.init(urlString: API.Urls.getReceiptList, parameters: params, method: .post, requireAccessToken: true)
        }
    }
}
