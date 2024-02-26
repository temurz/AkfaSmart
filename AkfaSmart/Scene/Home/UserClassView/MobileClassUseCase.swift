//
//  MobileClassUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 26/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol MobileClassUseCaseType {
    func getMobileClassInfo() -> Observable<MobileClass>
    func getMobileClassImage(_ urlString: String) -> Observable<Data>
}

struct MobileClassUseCase: MobileClassUseCaseType, MobileClassInfoDomainUseCaseType {
    var gateway: MobileClassGatewayType
}
