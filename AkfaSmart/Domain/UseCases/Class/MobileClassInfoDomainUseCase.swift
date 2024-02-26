//
//  MobileClassInfoDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 26/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol MobileClassInfoDomainUseCaseType {
    var gateway: MobileClassGatewayType { get }
}

extension MobileClassInfoDomainUseCaseType {
    func getMobileClassInfo() -> Observable<MobileClass> {
        gateway.getMobileClassInfo()
    }
    
    func getMobileClassImage(_ urlString: String) -> Observable<Data> {
        gateway.getMobileClassImage(urlString)
    }

}
