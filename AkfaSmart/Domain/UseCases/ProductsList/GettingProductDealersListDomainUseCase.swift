//
//  GettingProductDealersListDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol GettingProductDealersListDomainUseCase {
    var gateway: ProductDealersListGatewayType { get }
}

extension GettingProductDealersListDomainUseCase {
    func getProductDealers(input: ProductDealersListInput, page: Int) -> Observable<PagingInfo<ProductDealerWithLocation>> {
        let dto = GetPageDto(page: page)
        return gateway.getProductDealers(dto: dto, input: input)
    }
}
