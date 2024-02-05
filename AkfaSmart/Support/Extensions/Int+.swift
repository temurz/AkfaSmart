//
//  Int+.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
extension Int {
    func makeMinutesAndSeconds() -> String {
        if self % 60 < 10 {
            let text = "\(self / 60):0\(self % 60)"
            return text
        }else {
            let text = "\(self / 60):\(self % 60)"
            return text
        }
    }
}
