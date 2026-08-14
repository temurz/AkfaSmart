//
//  CartItem.swift
//  AkfaSmart
//

import Foundation
struct CartItem: Decodable, Identifiable {
    let id: Int
    let adwProductId: Int?
    let productName: String?
    let groupName: String?
    let price: Double?
    let quantity: Double

    var quantityInt: Int {
        Int(quantity)
    }
}

struct CartSummary: Decodable {
    let id: Int?
    let totalPrice: Double
    let totalQuantity: Double
    let items: [CartItem]
}

struct InCartItemsCount: Decodable {
    let count: Int?
}
