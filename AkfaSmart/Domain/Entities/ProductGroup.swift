//
//  ProductGroup.swift
//  AkfaSmart
//

import Foundation
struct ProductGroup: Decodable, Identifiable {
    let id: Int
    let text: String
    let children: [ProductGroup]?
}
