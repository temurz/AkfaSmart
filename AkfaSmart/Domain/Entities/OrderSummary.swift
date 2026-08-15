//
//  OrderSummary.swift
//  AkfaSmart
//

import Foundation
struct OrderSummary: Decodable, Identifiable {
    let id: Int
    let orderStatus: String?
    let totalQuantity: Double?
    let totalPrice: Double?
    let dealerName: String?
}

enum OrderListStatus: String, CaseIterable {
    case new = "NEW"
    case inDealer = "IN_DEALER"
    case approved = "APPROVED"
    case canceled = "CANCELED"

    var title: String {
        switch self {
        case .new: return "ORDER_STATUS_NEW".localizedString
        case .inDealer: return "ORDER_STATUS_IN_DEALER".localizedString
        case .approved: return "ORDER_STATUS_APPROVED".localizedString
        case .canceled: return "ORDER_STATUS_CANCELED".localizedString
        }
    }
}
