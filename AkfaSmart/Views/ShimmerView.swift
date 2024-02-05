//
//  ShimmerView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import SwiftUI
struct ShimmerView: View {
    
    @State private var shimmering = false
    
    let streamSnow = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    let streamGray = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(streamSnow), Color(streamGray)]),
                       startPoint: .bottomLeading,
                       endPoint: shimmering ? .topTrailing : .topLeading)
//        .frame(width: 200, height: 40)
        .mask(RoundedRectangle(cornerRadius: 10))
        .animation(.easeOut(duration: 2).repeatForever(autoreverses: true).delay(3), value: shimmering)
        .onAppear {
            shimmering.toggle()
        }
    }
}
