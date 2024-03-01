//
//  ProductWithName.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct ProductWithName: Decodable {
    let name: String
    let id: Int
    let rate: Double
    let baseUnitName: String
    let groupName: String
}
