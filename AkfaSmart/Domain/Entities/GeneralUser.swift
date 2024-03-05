//
//  GeneralUser.swift
//  AkfaSmart
//
//  Created by Temur on 05/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct GeneralUser: Decodable {
    let username: String?
    let imageUrl: String?
    let firstName: String?
    let lastName: String?
    let middleName: String?
    let hasDealer: Bool?
    let hasLocation: Bool?
}
