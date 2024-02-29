//
//  ClassDetailUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ClassDetailViewUseCaseType {
    func getClassDetail() -> Observable<[MobileClassDetail]>
}

struct ClassDetailViewUseCase: ClassDetailViewUseCaseType, ClassDetailDomainUseCase {
    var gateway: ClassDetailGatewayType
}
