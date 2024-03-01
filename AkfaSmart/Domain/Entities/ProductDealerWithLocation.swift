//
//  ProductDealerWithLocation.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct ProductDealerWithLocation: Decodable {
    let address: String
    let name: String
    let id: Int
    let distance: Double
    let dealerId: Int
    let rate: Double
    let longitude: Double
    let latitude: Double
    let phones: String
    let regionName: String
    let dealerName: String
    let baseUnitName: String
    let groupName: String
}
