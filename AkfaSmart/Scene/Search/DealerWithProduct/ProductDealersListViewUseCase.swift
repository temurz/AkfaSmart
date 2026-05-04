//
//  ProductOwnersListViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct ProductDealersListInput {
    let productName: String
    let latitude: Double
    let longitude: Double
}

struct ProductDealersByIdInput {
    let productId: Int
    let latitude: Double
    let longitude: Double
}

protocol ProductDealersListViewUseCaseType {
    func getProductDealers(input: ProductDealersListInput, page: Int) -> Observable<PagingInfo<ProductDealerWithLocation>>
    func getProductDealersById(input: ProductDealersByIdInput, page: Int) -> Observable<PagingInfo<ProductDealerWithLocation>>
}

struct ProductDealersListViewUseCase: ProductDealersListViewUseCaseType, GettingProductDealersListDomainUseCase {
    var gateway: ProductDealersListGatewayType
}
