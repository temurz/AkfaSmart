//
//  MarketingGraphicsGateway.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol MarketingGraphicsGatewayType {
    func getMarketingGraphics() -> Observable<MarketingGraphics>
}

struct MarketingGraphicsGateway: MarketingGraphicsGatewayType {
    func getMarketingGraphics() -> Observable<MarketingGraphics> {
        let input = API.GetMarketingGraphicsInput()
        return API.shared.getMarketingGraphics(input)
    }
}
