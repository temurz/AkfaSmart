//
//  TechnoGraphicsDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol TechnoGraphicsDomainUseCase {
    var gateway: TechnoGraphicsGatewayType { get }
}

extension TechnoGraphicsDomainUseCase {
    func getTechnoGraphics() -> Observable<TechnoGraphics> {
        gateway.getTechnoGraphics()
    }
}
