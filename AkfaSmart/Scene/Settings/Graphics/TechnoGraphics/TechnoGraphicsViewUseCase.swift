//
//  TechnoGraphicsViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol TechnoGraphicsViewUseCaseType {
    func getTechnoGraphics() -> Observable<TechnoGraphics>
}

struct TechnoGraphicsViewUseCase: TechnoGraphicsViewUseCaseType, TechnoGraphicsDomainUseCase {
    var gateway: TechnoGraphicsGatewayType
}
