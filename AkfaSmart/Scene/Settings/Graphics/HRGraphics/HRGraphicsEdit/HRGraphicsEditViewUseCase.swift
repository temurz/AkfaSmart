//
//  HRGraphicsEditViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol HRGraphicsEditViewUseCaseType {
    func editHRGraphics(_ model: HRGraphics) -> Observable<Bool>
}

struct HRGraphicsEditViewUseCase: HRGraphicsEditViewUseCaseType, HRGraphicsEditDomainUseCase {
    var gateway: HRGraphicsEditGatewayType
}
