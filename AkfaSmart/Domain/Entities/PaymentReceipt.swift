//
//  PaymentReceipt.swift
//  AkfaSmart
//
//  Created by Temur on 07/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct PaymentReceipt: Decodable {
    let type: String?
    let date: Int?
    let status: String?
    let amount: Double?
    let info: String?
    let uniqueId: String?
    let toClientName: String?
    let dealerName: String?
    let fromClientName: String?
}

struct ReceiptsInput {
    let from: Date?
    let to: Date?
    let type: String
}

