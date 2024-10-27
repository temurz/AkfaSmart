//
//  Double+.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/15/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//
import Foundation
extension Double {
    var currency: String {
        return String(format: "$%.02f", self)
    }
}

extension Double {
//    var uzCurrency: String {
//        let afterDot = modf(self)
//        if afterDot.1 > 0 {
//            return String(format: "%.2f", self)
//        }else {
//            return String(format: "%.0f", self)
//        }
//    }
//    
//    func convertDecimals() -> String {
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal
//        numberFormatter.maximumFractionDigits = 0;
//
//        let result = numberFormatter.string(from: self as NSNumber)
//        return result ?? ""
//    }
    
    func convertDecimals() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        // Get the decimal portion of the number
        let decimalPortion = self - Double(Int(self))
        
        if decimalPortion == 0 {
            // If there are no decimals, don't show any decimal digits
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
        } else {
            // If there are decimals, show exactly 2 decimal digits
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
        }

        formatter.groupingSeparator = " "

        if let formattedString = formatter.string(from: NSNumber(value: self)) {
            return formattedString
        }
        
        return "\(self)"
    }
}
