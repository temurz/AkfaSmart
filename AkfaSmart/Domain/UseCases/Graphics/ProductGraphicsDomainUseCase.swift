//
//  ProductGraphicsDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ProductGraphicsDomainUseCase {
    var gateway: ProductGraphicsGatewayType { get }
}

extension ProductGraphicsDomainUseCase {
    func getProductGraphics() -> Observable<ProductGraphics> {
        gateway.getProductGraphics()
    }
}
