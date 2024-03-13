//
//  TechnoGraphics.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation

struct TechnoGraphics: Codable {
    let longitude: Double?
    var longitudeEdited: Double?
    let latitude: Double?
    var latitudeEdited: Double?
    let area: Double?
    var areaEdited: Double?
    let hasGlassWorkshop: Bool?
    var hasGlassWorkshopEdited: Bool?
    let tools: [ModelWithIdAndName]
    var toolsEdited: [ModelWithIdAndName]
    let workWithSeries: [ModelWithIdAndName]
    
    mutating func edit(
        longitudeEdited: Double?,
        latitudeEdited: Double?,
        areaEdited: Double?,
        hasGlassWorkshopEdited: Bool?,
        toolsEdited: [ModelWithIdAndName]
    ) {
        self.longitudeEdited = longitudeEdited
        self.latitudeEdited = latitudeEdited
        self.areaEdited = areaEdited
        self.hasGlassWorkshopEdited = hasGlassWorkshopEdited
        self.toolsEdited = toolsEdited
    }
}

struct ModelWithIdAndName: Codable {
    let id: Int
    let name: String?
}
