//
//  Validation+.swift
//  AkfaSmart
//
//  Created by Temur on 20/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import ValidatedPropertyKit
extension Validation where Value == String {
    static func minimumCharacters(_ count: Int) -> Validation {
        return .init { value in
            if count <= value.count {
                return .success(())
            } else {
                return .failure("Minimum number of letters is \(count)")
            }
        }
    }
}


extension Validation where Value == String {
    static func validPhoneNumber(_ count: Int = 12) -> Validation {
        return .init { value in
            if count == value.getOnlyNumbers().count {
                return .success(())
            }else {
                return .failure("The phone number should be in +998(**) ***-**-** format")
            }
        }
    }
}
