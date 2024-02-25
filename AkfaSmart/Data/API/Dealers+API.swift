//
//  Dealers+API.swift
//  AkfaSmart
//
//  Created by Temur on 25/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Alamofire
extension API {
    func getDealers(_ input: GetDealersInput) -> Observable<[Dealer]> {
        requestList(input)
    }
    
    final class GetDealersInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getDealersInfo, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}

extension API {
    func hasADealer(_ input: HasDealerCheckInput) -> Observable<HasDealerAndLocation> {
        request(input)
    }
    
    final class HasDealerCheckInput: APIInput {
        init() {
            super.init(urlString: API.Urls.hasADealerAndLocationCheck, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}
