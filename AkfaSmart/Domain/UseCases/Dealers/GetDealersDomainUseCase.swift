//
//  GetDealersDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 25/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import UIKit
protocol GetDealersDomainUseCase {
    var gateway: GetDealersGatewayType { get }
}

extension GetDealersDomainUseCase {
    func getDealers() -> Observable<[Dealer]> {
        gateway.getDealers()
    }
    
    func checkHasADealer() -> Observable<Bool> {
        gateway.checkHasADealer()
    }
}
