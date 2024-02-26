//
//  MobileClassGateway.swift
//  AkfaSmart
//
//  Created by Temur on 26/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol MobileClassGatewayType {
    func getMobileClassInfo() -> Observable<MobileClass>
    func getMobileClassImage(_ urlString: String) -> Observable<Data>
}

struct MobileClassGateway: MobileClassGatewayType {
    func getMobileClassInfo() -> Observable<MobileClass> {
        let input = API.GetMobileClassInfoInput()
        return API.shared.getUserClassInfo(input)
    }
    
    func getMobileClassImage(_ urlString: String) -> Observable<Data> {
        let input = API.GetMobileClassImageInput(urlString)
        return API.shared.getUserClassImage(input)
    }
}
