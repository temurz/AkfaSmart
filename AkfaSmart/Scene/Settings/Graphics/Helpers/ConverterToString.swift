//
//  ConverterToString.swift
//  AkfaSmart
//
//  Created by Temur on 05/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftUI
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
            return bool ? "YES".localizedString : "NO".localizedString
        }else {
            return ""
        }
    }
    
    static func minMaxText(min: Double, max: Double) -> AttributedString {
        var text = AttributedString("")
        let localizedMin = AttributedString("MIN".localizedString)
        let localizedMax = AttributedString("MAX".localizedString)
        var maxBold = AttributedString("\(max)")
        var minBold = AttributedString("\(min)")
        maxBold.font = .bold(Font.headline)()
        maxBold.foregroundColor = .black
        maxBold.backgroundColor = Color(hex: "#DFE3EB")
        minBold.font = .bold(Font.headline)()
        minBold.foregroundColor = .black
        minBold.backgroundColor = Color(hex: "#DFE3EB")
        
        if min == 0 {
            text = localizedMax + maxBold
        }else if max == 0 {
            text = localizedMin + minBold
        }else {
            text = localizedMin + minBold + localizedMax + maxBold
        }
        
        return text
    }
    
    static func getMarriedStatus(bool: Bool?, isEdited: Bool = false) -> String {
        if let bool = bool {
            return bool ? "MARRIED".localizedString : "SINGLE".localizedString
        }else {
            return ""
        }
    }
    
    static func getArea(area: Double?) -> String {
        if let area {
            return area > 0 ? "\(area)" + "SQ_M".localizedString : ""
        }else {
            return ""
        }
    }
    
    static func getAmount(from amount: Int?) -> String {
        if let amount {
            return amount > 0 ? "\(amount)" : ""
        }else {
            return ""
        }
    }
    
    static func getClassProductsAttributed(products: [ModelWithIdAndName]) -> AttributedString {
        let products = ConverterToString.getStringFrom(products)
        
        var result = AttributedString(products)
        result.font = .bold(Font.headline)()
        result.foregroundColor = .black
        result.backgroundColor = Color(hex: "#DFE3EB")
        return result
    }
    
    static func addBackgroundToString(_ text: String) -> AttributedString {
        var result = AttributedString(text)
        result.font = .bold(Font.headline)()
        result.foregroundColor = .black
        result.backgroundColor = Color(hex: "#DFE3EB")
        return result
    }
    
    static func reverseGeocode(latitude: Double, longitude: Double, completion: @escaping (String) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        let locale = Locale(identifier: AuthApp.shared.language)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { (placemarks, error) in
            guard error == nil, let placemark = placemarks?.first else {
                print("Reverse geocoding failed with error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            var addressString = ""
            
            if let name = placemark.name {
                addressString += name + ", "
            }
//                if let thoroughfare = placemark.thoroughfare {
//                    addressString += thoroughfare + ", "
//                }
//                if let locality = placemark.locality {
//                    addressString += locality + ", "
//                }
            if let administrativeArea = placemark.administrativeArea {
                addressString += administrativeArea + ", "
            }
            if let country = placemark.country {
                addressString += country
            }
            
            completion(addressString)
        }
    }
}
