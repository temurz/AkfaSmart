//
//  ProductGraphicsGateway.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ProductGraphicsGatewayType {
    func getProductGraphics() -> Observable<ProductGraphics>
}

struct ProductGraphicsGateway: ProductGraphicsGatewayType {
    func getProductGraphics() -> Observable<ProductGraphics> {
        let input = API.GetProductGraphicsInput()
        return API.shared.getProductGraphics(input)
    }
}
