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
    var firstNameEdited:  String?
    let lastName:  String?
    var lastNameEdited:  String?
    let middleName:  String?
    var middleNameEdited:  String?
    
    let isMarried: Bool?
    var isMarriedEdited: Bool?
    let dateOfBirth: String?
    var dateOfBirthEdited: String?
    let address: String?
    var addressEdited: String?
    let nation: String?
    var nationEdited: String?
    let education: String?
    var educationEdited: String?
    let ownedLanguages: [ModelWithIdAndName]
    var ownedLanguagesEdited: [ModelWithIdAndName]
    let numberOfChildren: Int?
    var numberOfChildrenEdited: Int?
    let klassName: String
    
    let region: Region
    var regionEdited: Region
    
    mutating func edit(
        firstNameEdited:  String?,
        lastNameEdited:  String?,
        middleNameEdited:  String?,
        isMarriedEdited: Bool?,
        dateOfBirth: String?,
        address: String?,
        nation: String?,
        educationEdited: String?,
        ownedLanguagesEdited: [ModelWithIdAndName],
        numberOfChildrenEdited: Int?,
        regionEdited: Region
    ) {
        self.firstNameEdited = firstNameEdited
        self.lastNameEdited = lastNameEdited
        self.middleNameEdited = middleNameEdited
        self.isMarriedEdited = isMarriedEdited
        self.dateOfBirthEdited = dateOfBirth
        self.addressEdited = address
        self.nationEdited = nation
        self.educationEdited = educationEdited
        self.ownedLanguagesEdited = ownedLanguagesEdited
        self.numberOfChildrenEdited = numberOfChildrenEdited
        self.regionEdited = regionEdited
    }
}


struct Region: Codable {
    let id: Int?
    let name: String?
    let parentId: Int?
    let parentName: String?
    let hasChild: Bool?
    
    init(id: Int?, name: String?, parentId: Int?, parentName: String?, hasChild: Bool?) {
        self.id = id
        self.name = name
        self.parentId = parentId
        self.parentName = parentName
        self.hasChild = hasChild
    }
    
    init() {
        id = nil
        name = nil
        parentId = nil
        parentName = nil
        hasChild = nil
    }
}

struct OwnedLanguage: Codable {
    let id: Int
    let name: String?
}
