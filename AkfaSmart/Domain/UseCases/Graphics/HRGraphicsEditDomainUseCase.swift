//
//  HRGraphicsEditDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol HRGraphicsEditDomainUseCase {
    var gateway: HRGraphicsEditGatewayType { get }
}

extension HRGraphicsEditDomainUseCase {
    func editHRGraphics(_ model: HRGraphics) -> Observable<Bool> {
        gateway.editHRGraphics(model)
    }
}
