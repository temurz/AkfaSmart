//
//  MarketingGraphicsViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol MarketingGraphicsViewUseCaseType {
    func getMarketingGraphics() -> Observable<MarketingGraphics>
}

struct MarketingGraphicsViewUseCase: MarketingGraphicsViewUseCaseType, MarketingGraphicsDomainUseCase {
    var gateway: MarketingGraphicsGatewayType
}
