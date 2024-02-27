//
//  HRGraphics.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct HRGraphics: Codable {
    let aboutEmployees: String?
    let aboutEmployeesEdited: String
    let hasAccountant: Bool?
    let hasAccountantEdited: Bool
    let hasSeller: Bool?
    let hasSellerEdited: Bool
    let numberOfEmployees: Int?
    let numberOfEmployeesEdited: Int
    let userAttendantTrainings: [ModelWithIdAndName]
    let userAttendantTrainingsEdited: [ModelWithIdAndName]
}
