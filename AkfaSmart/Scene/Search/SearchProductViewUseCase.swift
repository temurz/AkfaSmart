//
//  CreateOrderUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 06/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol SearchProductViewUseCaseType {
    func getProductsList(text: String, page: Int) -> Observable<PagingInfo<ProductWithName>>
}

struct SearchProductViewUseCase: SearchProductViewUseCaseType, GettingProductsDomainUseCase {
    var gateway: ProductsListGatewayType   
}
