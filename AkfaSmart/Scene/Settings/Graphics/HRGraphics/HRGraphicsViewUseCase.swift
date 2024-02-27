//
//  HRGraphicsViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol HRGraphicsViewUseCaseType {
    func getHRGraphics() -> Observable<HRGraphics>
}

struct HRGraphicsViewUseCase: HRGraphicsViewUseCaseType, HRGraphicsDomainUseCase {
    var gateway: HRGatewayType
}
