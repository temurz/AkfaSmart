//
//  String+Extension.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
extension Date {
    func convertToDateUS() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let result = dateFormatter.string(from: self)
        return result
    }
}
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
    
    func revertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: self)
    }
    
    func removePlusFromPhoneNumber() -> String {
        let text = Array(self)
        if text[0] == "+" {
            return String(text.dropFirst())
        }else {
            return String(text)
        }
    }
    
    func getOnlyNumbers() -> String {
        let text = self.filter("0123456789.".contains)
        return text
    }
    
    func formatToUzNumber() -> String {
        guard self.count >= 12 else { return self}
        let text = Array(self)
        var result = text
        if text[0] != "+" {
            result.insert("+", at: 0)
        }
        result.insert(" ", at: 4)
        result.insert("(", at: 5)
        result.insert(")", at: 8)
        result.insert(" ", at: 9)
        result.insert(" ", at: 13)
        result[14] = "*"
        result[15] = "*"
        result.insert(" ", at: 15)
        
        return String(result)
    }
    
    func formatPhoneNumber() -> String {
        let cleanNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let mask = "+XXX(XX) XXX-XX-XX"
        
        var result = ""
        var startIndex = cleanNumber.startIndex
        var endIndex = cleanNumber.endIndex
        
        for char in mask where startIndex < endIndex {
            if char == "X" {
                result.append(cleanNumber[startIndex])
                startIndex = cleanNumber.index(after: startIndex)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
    
    func addSpaces(byEvery num: Int) -> String {
        let initial = self
        var result = ""
        
        initial.enumerated().forEach { i, char in
            
            if i > 0 && i%num == 0 {
                result.append(" ")
                result.append(char)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
}
