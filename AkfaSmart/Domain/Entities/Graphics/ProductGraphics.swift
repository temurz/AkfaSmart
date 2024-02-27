//
//  ProductGraphics.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct ProductGraphics: Codable {
    let annualBuyAmount: Double?
    let annualBuyWeight: Double?
    let dealerNames: String
    let annualBuyWeightDetail: [BuyWeightDetail]
}

struct BuyWeightDetail: Codable {
    let id: Int
    let name: String
    let weight: Double
}
