//
//  ProductsListGateway.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ProductsListGatewayType {
    func getProductsList(text: String, groupId: Int?, dto: GetPageDto) -> Observable<PagingInfo<ProductWithName>>
    func getProductGroupTree() -> Observable<[ProductGroup]>
}

struct ProductsListGateway: ProductsListGatewayType {
    func getProductsList(text: String, groupId: Int?, dto: GetPageDto) -> Observable<PagingInfo<ProductWithName>> {
        let input = API.GetProductsListInput(text: text, groupId: groupId, dto: dto)
        return API.shared.getProducts(input)
            .tryMap { output in
                return output
            }
            .replaceNil(with: [])
            .map { PagingInfo(page: dto.page, items: $0, hasMorePages: $0.count == dto.perPage) }
            .eraseToAnyPublisher()
    }

    func getProductGroupTree() -> Observable<[ProductGroup]> {
        API.shared.getProductGroupTree(API.GetProductGroupTreeInput())
    }
}
