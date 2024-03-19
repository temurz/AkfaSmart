//
//  Network.swift
//  AkfaSmart
//
//  Created by Temur on 28/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct Base {
//    static let BASE_URL = "http://api-smart.akfadiler.uz" //
    static let BASE_URL = "http://84.54.75.248:1030"
}

struct ResponseModel<T: Decodable>: Decodable {
    let success: Bool
    let message: String
    let body: T?
    let code: Int
}

struct SuccessResponseModel: Decodable {
    let success: Bool
    let message: String
    let code: Int
}
