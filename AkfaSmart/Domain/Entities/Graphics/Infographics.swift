//
//  Infographics.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct Infographics: Codable {
    let firstName: String?
    let firstNameEdited:  String?
    let lastName:  String?
    let lastNameEdited:  String?
    let middleName:  String?
    let middleNameEdited:  String?
    
    let isMarried: Bool?
    let isMarriedEdited: Bool?
    let dateOfBirth: String?
    let dateOfBirthEdited: String?
    let address: String?
    let addressEdited: String?
    let nation: String?
    let nationEdited: String?
    let education: String?
    let educationEdited: String?
    let ownedLanguages: [ModelWithIdAndName]
    let ownedLanguagesEdited: [ModelWithIdAndName]
    let numberOfChildren: Int?
    let numberOfChildrenEdited: Int
    let klassName: String
    
    let region: Region
    let regionEdited: Region
}


struct Region: Codable {
    let id: Int?
    let name: String?
    let parentId: Int?
    let parentName: String?
    let hasChild: Bool?
}

struct OwnedLanguage: Codable {
    let id: Int
    let name: String?
}
