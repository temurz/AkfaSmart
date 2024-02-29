//
//  ClassDetailDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ClassDetailDomainUseCase {
    var gateway: ClassDetailGatewayType { get }
}

extension ClassDetailDomainUseCase {
    func getClassDetail() -> Observable<[MobileClassDetail]> {
        gateway.getClassDetail()
    }
}
