//
//  ConverterToString.swift
//  AkfaSmart
//
//  Created by Temur on 05/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct ConverterToString {
    static func getStringFrom(_ modelsWithName: [ModelWithIdAndName], isEdited: Bool = false) -> String {
        let array = modelsWithName.map { $0.name ?? "" }
        if modelsWithName.isEmpty {
//            return isEdited ? "" : "No information"
            return ""
        }
        return array.joined(separator: ", ")
    }
    
    static func createFullName(from names: [String?], isEdited: Bool = false) -> String {
        var text = ""
        names.forEach { optionalString in
            text += optionalString ?? ""
            text += " "
        }
        let trimmedString = text.trimmingCharacters(in: .whitespaces)
//        if isEdited {
            return trimmedString.isEmpty ? "" : text
//        }else {
//            return trimmedString.isEmpty ? "No information" : text
//        }
    }
    
    static func getYesOrNoString(_ bool: Bool?, isEdited: Bool = false) -> String {
        if let bool = bool {
            return bool ? "Yes" : "No"
        }else {
            return ""
        }
    }
    
    static func minMaxText(min: Double, max: Double) -> String {
        if min == 0 {
            return "eng kamida \(max)"
        }else {
            return "eng ko'pi \(min)"
        }
    }
    
    static func getMarriedStatus(bool: Bool?, isEdited: Bool = false) -> String {
        if let bool = bool {
            return bool ? "Married" : "Single"
        }else {
            return ""
        }
    }
    
    static func getArea(area: Double?) -> String {
        if let area {
            return area > 0 ? "\(area)" + " sq.km" : ""
        }else {
            return ""
        }
    }
}
