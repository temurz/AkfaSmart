//
//  PromotionViewCell.swift
//  AkfaSmart
//
//  Created by Temur on 12/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import SwiftUI

struct PromotionViewCell: View {
    let model: Promotion
    
    let imageWidth = (Constants.screenWidth - 64) * 0.38
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                VStack(spacing: 16) {
                    Text(model.title ?? "")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(model.description ?? "")
                        .foregroundStyle(.white)
                        .fontWeight(.heavy)
                        .font(.footnote)
                }
                VStack {
                    Spacer()
                    Image(.samplePromotion)
                        .background(.clear)
                        .frame(width: imageWidth, height: imageWidth*0.7)
                        .padding(4)
                        
                }
            }
            VStack {
                Text("00 : 59 : 12")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Color.black.opacity(0.18)
                            .blur(radius: 4)
                            .cornerRadius(6)
                    )
                    
                Spacer()
            }
            
        }
        .padding()
        .background(Color(hex: model.backgroundColor ?? "#86B1E0"))
        .cornerRadius(12, corners: .allCorners)
    }
}
