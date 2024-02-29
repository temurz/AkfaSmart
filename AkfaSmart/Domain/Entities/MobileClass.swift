//
//  MobileClass.swift
//  AkfaSmart
//
//  Created by Temur on 25/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct MobileClass: Decodable {
    let id: Int
    let klassName: String?
    let klassGroupName: String?
    let klassGroupTitle: String?
    let backgroundColor: String?
    let logoImgUrl: String?
}

struct MobileClassDetail: Decodable {
    let c1Id: Int
    let c1Type: String
    let c1Amount: Double
    let c1MaxWeight: Double
    let c1MinWeight: Double
    let c1KlassProductGroups: [ModelWithIdAndName]
    let c1AmountDetail: [ClassAmountDetail]
    let c2ObjectList: [AdditionalClassDetail]
    
}

struct ClassAmountDetail: Decodable {
    let id: Int
    let name: String?
    let amount: Double?
}

struct AdditionalClassDetail: Decodable {
    let c2Id: Int
    let c2Type: String?
    let c2Amount: Double
    let c2Percent: Double
    let c2KlassProductGroupIds: [Int]
    let c2KlassProductGroups: [ModelWithIdAndName]
}
