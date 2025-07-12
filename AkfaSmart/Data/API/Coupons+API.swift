//
//  Coupons+API.swift
//  AkfaSmart
//
//  Created by Temur on 12/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

extension API {
    func getPromotionsList(_ input: GetPromotionListAPIInput) -> Observable<[Promotion]> {
        requestList(input)
    }
    
    final class GetPromotionListAPIInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getPromotionList, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}

extension API {
    func getCouponItems(_ input: GetCouponItemsAPIInput) -> Observable<[CouponInfo]> {
        requestList(input)
    }
    
    final class GetCouponItemsAPIInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getCouponItems, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}
