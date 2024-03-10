//
//  MessageModel.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 11/03/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation

struct MessageModel:Decodable {
    
    let text: String?
    let date: String?
    let mobileUserId: Int?
    let userId: Int?
    let username: String?
//    let fileUrls: [],
//    let imageHeight48Urls: [],
//    let fileNames: []
}
