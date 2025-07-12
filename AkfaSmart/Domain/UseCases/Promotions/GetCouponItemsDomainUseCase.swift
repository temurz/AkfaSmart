//
//  GetCouponItems.swift
//  AkfaSmart
//
//  Created by Temur on 12/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

protocol GetCouponItemsDomainUseCase {
    var gateway: GetCouponItemsGatewayProtocol { get }
}

extension GetCouponItemsDomainUseCase {
    func getPromotionsList() -> Observable<[CouponInfo]> {
        gateway.getCouponItems()
    }
}
