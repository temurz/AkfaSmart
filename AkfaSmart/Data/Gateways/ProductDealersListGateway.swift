//
//  ProductDealersListGateway.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ProductDealersListGatewayType {
    func getProductDealers(dto: GetPageDto, input: ProductDealersListInput) -> Observable<PagingInfo<ProductDealerWithLocation>>
    func getProductDealersById(dto: GetPageDto, input: ProductDealersByIdInput) -> Observable<PagingInfo<ProductDealerWithLocation>>
}

struct ProductDealersListGateway: ProductDealersListGatewayType {
    func getProductDealers(dto: GetPageDto, input: ProductDealersListInput) -> Observable<PagingInfo<ProductDealerWithLocation>> {
        let input = API.GetProductDealersListInput(dto: dto, input: input)
        return API.shared.getProductDealers(input)
            .tryMap { output  in
                return output
            }
            .replaceNil(with: [])
            .map { PagingInfo(page: dto.page, items: $0, hasMorePages: $0.count == dto.perPage)}
            .eraseToAnyPublisher()
    }
    
    func getProductDealersById(dto: GetPageDto, input: ProductDealersByIdInput) -> Observable<PagingInfo<ProductDealerWithLocation>> {
        let input = API.GetProductDealersByIdInput(dto: dto, input: input)
        return API.shared.getProductDealersById(input)
            .tryMap { $0 }
            .replaceNil(with: [])
            .map { PagingInfo(page: dto.page, items: $0, hasMorePages: $0.count == dto.perPage)}
            .eraseToAnyPublisher()
    }
}
