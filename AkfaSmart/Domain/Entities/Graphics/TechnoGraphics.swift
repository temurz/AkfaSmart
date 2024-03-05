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
    let longitudeEdited: Double?
    let latitude: Double?
    let latitudeEdited: Double?
    let area: Double?
    let areaEdited: Double?
    let hasGlassWorkshop: Bool?
    let hasGlassWorkshopEdited: Bool?
    let tools: [ModelWithIdAndName]
    let toolsEdited: [ModelWithIdAndName]
    let workWithSeries: [ModelWithIdAndName]
}

struct ModelWithIdAndName: Codable {
    let id: Int
    let name: String?
}
