//
//  MarketingGraphicsDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol MarketingGraphicsDomainUseCase {
    var gateway: MarketingGraphicsGatewayType { get }
}

extension MarketingGraphicsDomainUseCase {
    func getMarketingGraphics() -> Observable<MarketingGraphics> {
        gateway.getMarketingGraphics()
    }
}
