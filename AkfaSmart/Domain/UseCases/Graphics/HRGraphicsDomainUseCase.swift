//
//  HRGraphicsDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol HRGraphicsDomainUseCase {
    var gateway: HRGatewayType { get }
}

extension HRGraphicsDomainUseCase {
    func getHRGraphics() -> Observable<HRGraphics> {
        gateway.getHRGraphics()
    }
}
