//
//  Dealer.swift
//  AkfaSmart
//
//  Created by Temur on 22/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct Dealer: Decodable {
    let dealerId: Int?
    let dealerClientCid: Int?
    let name: String?
    let clientName: String?
    let balance: Double
    let purchaseForMonth: Double
    let purchaseForYear: Double
}