//
//  InfographicsViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol InfographicsViewUseCaseType {
    func getInfographics() -> Observable<Infographics>
}

struct InfographicsViewUseCase: InfographicsViewUseCaseType, InfographicsDomainUseCase {
    var gateway: InfoGraphicsGatewayType
}
