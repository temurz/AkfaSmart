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
    var uzCurrency: String {
        let afterDot = modf(self)
        if afterDot.1 > 0 {
            return String(format: "%.2f", self)
        }else {
            return String(format: "%.0f", self)
        }
    }
}
