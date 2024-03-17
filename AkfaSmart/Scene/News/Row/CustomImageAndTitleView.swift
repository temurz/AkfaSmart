//
//  CustomCellView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct CustomImageAndTitleView: View {
    let data: Data
    let height: CGFloat = 200
    var body: some View {
//        GeometryReader { geometry in
            
            Image(data: data)?
                .resizable()
                .scaledToFill()
//                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width - 32)
                .frame(height: height)
                .clipped()
                .cornerRadius(8)
//        }
    }
}
