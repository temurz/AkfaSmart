//
//  Dealer.swift
//  AkfaSmart
//
//  Created by Temur on 22/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct Dealer: Decodable, Equatable {
    let dealerId: Int?
    let dealerClientCid: Int?
    let name: String?
    let clientName: String?
    let balance: Double
    let purchaseForMonth: Double
    let purchaseForYear: Double
    
    init(dealerId: Int?, dealerClientCid: Int?, name: String?, clientName: String?, balance: Double, purchaseForMonth: Double, purchaseForYear: Double) {
        self.dealerId = dealerId
        self.dealerClientCid = dealerClientCid
        self.name = name
        self.clientName = clientName
        self.balance = balance
        self.purchaseForMonth = purchaseForMonth
        self.purchaseForYear = purchaseForYear
    }
    
    
    init() {
        self.dealerId = nil
        self.dealerClientCid = nil
        self.name = nil
        self.clientName = nil
        self.balance = 0.0
        self.purchaseForMonth = 0.0
        self.purchaseForYear = 0.0

    }
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
