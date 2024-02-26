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
    var body: some View {
        Group {
            
            Image(data: data)?
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .padding()
                .cornerRadius(16)
                .frame(height: 200)
        }
    }
}
