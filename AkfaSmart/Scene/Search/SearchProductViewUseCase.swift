//
//  CreateOrderUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 06/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol SearchProductViewUseCaseType {
    func getProductsList(text: String, groupId: Int?, page: Int) -> Observable<PagingInfo<ProductWithName>>
    func getProductGroupTree() -> Observable<[ProductGroup]>
    func saveOrderItem(productId: Int, quantity: Int) -> Observable<Bool>
}

struct SearchProductViewUseCase: SearchProductViewUseCaseType, GettingProductsDomainUseCase {
    var gateway: ProductsListGatewayType
    var orderGateway: OrderGatewayType

    func saveOrderItem(productId: Int, quantity: Int) -> Observable<Bool> {
        orderGateway.saveOrderItem(productId: productId, quantity: quantity)
    }
}
