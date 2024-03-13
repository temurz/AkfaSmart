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
    var aboutEmployeesEdited: String?
    let hasAccountant: Bool?
    var hasAccountantEdited: Bool?
    let hasSeller: Bool?
    var hasSellerEdited: Bool?
    let numberOfEmployees: Int?
    var numberOfEmployeesEdited: Int?
    let userAttendantTrainings: [ModelWithIdAndName]
    var userAttendantTrainingsEdited: [ModelWithIdAndName]
    
    mutating func edit(
        aboutEmployeesEdited: String?,
        hasAccountantEdited: Bool?,
        hasSellerEdited: Bool?,
        numberOfEmployeesEdited: Int?,
        userAttendantTrainingsEdited: [ModelWithIdAndName]
    ) {
        self.aboutEmployeesEdited = aboutEmployeesEdited
        self.hasAccountantEdited = hasAccountantEdited
        self.hasSellerEdited = hasSellerEdited
        self.numberOfEmployeesEdited = numberOfEmployeesEdited
        self.userAttendantTrainingsEdited = userAttendantTrainingsEdited
    }
}
