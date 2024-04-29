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

struct HasDealerAndLocation: Decodable {
    let username: String
    let imageUrl: String?
    let firstName: String?
    let lastName: String?
    let middleName: String?
    let hasDealer: Bool?
    let hasLocation: Bool?
}


struct AddDealer: Codable {
    let phone: String?
    let dealerId: Int?
    let printableName: String?
    let cid: Int?
}

struct GetUserInfoResponse: Decodable {
    let username: String?
    let imageUrl: String?
    let firstName: String?
    let lastName: String?
    let middleName: String?
}
