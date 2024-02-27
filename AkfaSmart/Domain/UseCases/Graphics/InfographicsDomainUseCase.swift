//
//  InfographicsDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol InfographicsDomainUseCase {
    var gateway: InfoGraphicsGatewayType { get }
}

extension InfographicsDomainUseCase {
    func getInfographics() -> Observable<Infographics> {
        gateway.getInfographics()
    }
}
