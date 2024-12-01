//
//  MyDealersViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 01/12/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol MyDealersViewUseCaseType {
    func getDealers() -> Observable<[Dealer]>
}

struct MyDealersViewUseCase: MyDealersViewUseCaseType, GetDealersDomainUseCase {
    var gateway: GetDealersGatewayType
}
