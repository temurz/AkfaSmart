//
//  Date+.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
extension Date {
    
    func toApiFormat()->String {
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"

        // Convert Date to String
        return dateFormatter.string(from: self)
    }
    
    func toShortFormat()->String{
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "dd.MM.yyyy"

        // Convert Date to String
        return dateFormatter.string(from: self)
    }
    
    func toShortAPIFormat() -> String{
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "yyyy-MM-dd"

        // Convert Date to String
        return dateFormatter.string(from: self)
    }
    
        var startOfDay: Date {
            return Calendar.current.startOfDay(for: self)
        }

        var startOfMonth: Date {

            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year, .month], from: self)

            return  calendar.date(from: components)!
        }

        var endOfDay: Date {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }

        var endOfMonth: Date {
            var components = DateComponents()
            components.month = 1
            components.second = -1
            return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
        }

        func isMonday() -> Bool {
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.weekday], from: self)
            return components.weekday == 2
        }
}
