//
//  MyCouponsViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 18/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

protocol MyCouponsViewUseCaseType {
    func getPromotionsList() -> Observable<[CouponInfo]>
}

struct MyCouponsViewUseCase: MyCouponsViewUseCaseType, GetCouponItemsDomainUseCase {
    var gateway: GetCouponItemsGatewayProtocol
    
}
