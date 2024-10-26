//
//  View+Extension.swift
//  AkfaSmart
//
//  Created by Temur on 21/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
extension View {
    func gradient(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) ->  LinearGradient {
        let gradient = Gradient(colors: colors)
        
        return LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint)
    }
}
