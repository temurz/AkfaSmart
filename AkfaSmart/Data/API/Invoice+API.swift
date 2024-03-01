//
//  Invoice+API.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Alamofire
extension API {
    func getInvoiceList(_ input: GetInvoiceListInput) -> Observable<[Invoice]> {
        requestList(input)
    }
    
    final class GetInvoiceListInput: APIInput {
        init(input: InvoiceInput, dto: GetPageDto) {
            let params: Parameters = [
                "from": input.from?.toShortFormat() ?? "",
                "to": input.to?.toShortFormat() ?? "",
                "type": input.type,
                "length": dto.perPage,
                "start": dto.page
            ]
            super.init(urlString: API.Urls.getInvoiceList, parameters: params, method: .post, requireAccessToken: true)
        }
    }
}
