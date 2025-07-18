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
    let date: Int?
    let cid: Int?
    let uniqueId: String?
    let status: String?
}


struct InvoiceDetail: Decodable {
    let status: String?
    let altQty: Double?
    let qty: Double?
    let rate: Double?
    let amount: Double?
    let uniqueId: String?
    let productName: String?
    let productGroupName: String?
}
