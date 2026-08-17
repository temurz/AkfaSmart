//
//  ProductWithName.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct ProductWithName: Decodable, Identifiable {
    let name: String?
    let id: Int
    let rate: Double?
    let baseUnitName: String?
    let groupName: String?
    let groupId: Int?

    private enum CodingKeys: String, CodingKey {
        case name = "productName"
        case id = "adwProductId"
        case rate = "price"
        case baseUnitName = "baseUnit"
        case groupName
        case groupId
    }
}
