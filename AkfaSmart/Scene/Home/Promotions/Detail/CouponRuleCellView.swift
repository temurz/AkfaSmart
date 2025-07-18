//
//  CouponRuleCell.swift
//  AkfaSmart
//
//  Created by Temur on 18/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import SwiftUI

struct CouponRuleCellView: View {
    let model: AllCouponInfo
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                createText("COUPON_COUNT".localizedString)
                createText("PURCHASE_DURATION".localizedString)
                createText("CARD_NUMBER".localizedString)
            }
            VStack(alignment: .leading, spacing: 8) {
                createText("\(model.couponCount ?? 0)")
                createText("\(model.acceptedLength ?? 0)")
                createText(model.cardCode ?? "")
            }
            Spacer()
        }
        .padding()
        .background(Color(hex: "#6895C6"))
        .cornerRadius(12, corners: .allCorners)
    }
    
    func createText(_ text: String) -> some View {
        Text(text)
            .foregroundStyle(.white)
            .font(.footnote)
    }
}
