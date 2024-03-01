//
//  GettingProductsDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol GettingProductsDomainUseCase {
    var gateway: ProductsListGatewayType { get }
}

extension GettingProductsDomainUseCase {
    func getProductsList(text: String, page: Int) -> Observable<PagingInfo<ProductWithName>> {
        let dto = GetPageDto(page: page)
        return gateway.getProductsList(text: text, dto: dto)
    }

}
