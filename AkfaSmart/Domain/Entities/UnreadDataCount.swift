//
//  UnreadDataCount.swift
//  AkfaSmart
//
//  Created by Temur on 10/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct UnreadDataCount: Decodable {
    let countUnreadMessages: Int
    let countUnreadArticles: Int
    let countUnreadNews:Int
    
    var hasUnreadData: Bool {
        countUnreadMessages != 0 &&
        countUnreadArticles != 0 &&
        countUnreadNews != 0
    }
}
