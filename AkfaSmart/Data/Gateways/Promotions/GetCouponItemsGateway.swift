//
//  GetCouponItemsGateway.swift
//  AkfaSmart
//
//  Created by Temur on 12/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

protocol GetCouponItemsGatewayProtocol {
    func getCouponItems() -> Observable<[CouponInfo]>
}

struct GetCouponItemsGateway: GetCouponItemsGatewayProtocol {
    func getCouponItems() -> Observable<[CouponInfo]> {
        let input = API.GetCouponItemsAPIInput()
        return API.shared.getCouponItems(input)
    }
}
