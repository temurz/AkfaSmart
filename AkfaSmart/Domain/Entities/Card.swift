//
//  Card.swift
//  AkfaSmart
//
//  Created by Temur on 21/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct Card: Decodable {
    let id: Int
    let balance: Double?
    let cardNumber: String?
    let displayName: String?
    let cardBackground: String?
    let cardHolderPhone: String?
    var isMain: Bool?
    let isBlocked: Bool?
    let status: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case balance
        case cardNumber = "card_number"
        case displayName
        case cardBackground
        case cardHolderPhone = "card_holder_phone"
        case isMain
        case isBlocked = "is_blocked"
        case status
    }
    
    func getColorStrings() -> [String] {
        if let cardBackground {
            return cardBackground.components(separatedBy: ",")
        } else {
            return Colors.redCardGradientHexString.components(separatedBy: ",")
        }
    }
    
    init(id: Int, balance: Double?, cardNumber: String?, displayName: String?, cardBackground: String?, cardHolderPhone: String?, isMain: Bool?, isBlocked: Bool?, status: String?) {
        self.id = id
        self.balance = balance
        self.cardNumber = cardNumber
        self.displayName = displayName
        self.cardBackground = cardBackground
        self.cardHolderPhone = cardHolderPhone
        self.isMain = isMain
        self.isBlocked = isBlocked
        self.status = status
    }
    
    init() {
        self.id = -1
        self.balance = nil
        self.cardNumber = nil
        self.displayName = nil
        self.cardBackground = nil
        self.cardHolderPhone = nil
        self.isMain = nil
        self.isBlocked = nil
        self.status = nil
    }
    
    init(isBlocked: Bool) {
        self.id = Int.max
        self.balance = nil
        self.cardNumber = nil
        self.displayName = nil
        self.cardBackground = nil
        self.cardHolderPhone = nil
        self.isMain = nil
        self.isBlocked = isBlocked
        self.status = nil
    }
    
    init(id: Int, displayName: String?, cardBackground: String?, isMain: Bool?) {
        self.id = id
        self.balance = 0
        self.cardNumber = nil
        self.displayName = nil
        self.cardBackground = cardBackground
        self.cardHolderPhone = nil
        self.isMain = isMain
        self.isBlocked = nil
        self.status = nil
    }
}
