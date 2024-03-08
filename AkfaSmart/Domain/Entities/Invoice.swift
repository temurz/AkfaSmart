//
//  Invoice.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct Invoice: Decodable {
    let dealerId: Int?
    let organizationType: String?
    let dealerName: String?
    let total: Double?
    let type: String?
    let date: String?
    let cid: Int?
    let uniqueId: String?
    let status: String?
}
