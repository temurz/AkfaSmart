//
//  ClassDetailGateway.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ClassDetailGatewayType {
    func getClassDetail() -> Observable<[MobileClassDetail]>
}

struct ClassDetailGateway: ClassDetailGatewayType {
    func getClassDetail() -> Observable<[MobileClassDetail]> {
        let input = API.GetUserClassDetailInput()
        return API.shared.getUserClassDetail(input)
    }
}
