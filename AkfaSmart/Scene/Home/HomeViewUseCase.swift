//
//  HomeViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol HomeViewUseCaseType {
    func getDealers() -> Observable<[Dealer]>
    func checkHasADealer() -> Observable<Bool>
}

struct HomeViewUseCase: HomeViewUseCaseType, GetDealersDomainUseCase {
    var gateway: GetDealersGatewayType
}
