//
//  Promotion.swift
//  AkfaSmart
//
//  Created by Temur on 12/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

struct Promotion: Decodable {
    let id: Int
    let title: String?
    let description: String?
    let details: String?
    let products: String?
    let prizes: String?
    let backgroundColor: String?
    let htmlContent: String?
    let image: String?
    let language: String?
    let languageId: String?
    let couponInfo: PromotionCouponInfo?
    let startTime: String?
    let endTime: String?
}

struct PromotionCouponInfo: Decodable {
    let crmCouponContent: [CouponInfo]
    let totalAcceptedLength: Int
    let totalCouponCount: Int
}
