//
//  String+Extension.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
extension String {
    func convertToDateUS() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set the locale to avoid any potential issues with different locales.
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXX" // Input format

        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd.MM.yyyy" // Output format
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate // Output: 2023-05-08
        }else {
            return ""
        }
    }
    
    func removePlusFromPhoneNumber() -> String {
        var text = Array(self)
        if text[0] == "+" {
            return String(text.dropFirst())
        }else {
            return String(text)
        }
    }
}
