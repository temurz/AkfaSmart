//
//  GetDealersGateway.swift
//  AkfaSmart
//
//  Created by Temur on 25/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol GetDealersGatewayType {
    func getDealers() -> Observable<[Dealer]>
    func checkHasADealer() -> Observable<Bool>
}

struct GetDealersGateway: GetDealersGatewayType {
    func getDealers() -> Observable<[Dealer]> {
        let input = API.GetDealersInput()
        return API.shared.getDealers(input)
    }
    
    func checkHasADealer() -> Observable<Bool> {
        let input = API.HasDealerCheckInput()
        return API.shared.hasADealer(input)
            .tryMap { hasDealerAndLocation in
                return hasDealerAndLocation.hasDealer ? true : false
            }
            .eraseToAnyPublisher()
    }
}
