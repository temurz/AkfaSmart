//
//  CouponItemCellView.swift
//  AkfaSmart
//
//  Created by Temur on 18/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import SwiftUI

struct CouponItemCellView: View {
    let model: CouponInfo
    var body: some View {
        HStack(spacing: 16) {
            Image(.plusCoupon)
                .resizable()
                .frame(width: 34, height: 34)
            VStack(alignment: .leading) {
                Text(model.couponCode ?? "")
                    .bold()
                    .foregroundStyle(Colors.dark)
                Text(model.name ?? "")
                    .font(.footnote)
                    .foregroundStyle(Colors.textSteelColor)
            }
            Spacer()
            VStack {
                Text(model.date ?? "")
                    .font(.footnote)
                    .bold()
                    .foregroundStyle(Colors.textSteelColor)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .background(Colors.borderGrayColor2)
                    .cornerRadius(6, corners: .allCorners)
                Spacer()
            }
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Colors.borderGrayColor2)
        }
    }
}
