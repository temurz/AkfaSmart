//
//  MyDealerRow.swift
//  AkfaSmart
//
//  Created by Temur on 01/12/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct MyDealerRow: View {
    let model: Dealer
    
    var body: some View {
        HStack {
            VStack {
                HStack(spacing: 8) {
                    Text("DEALER".localizedString)
                        .foregroundColor(Colors.secondaryTextColor)
                        .font(.subheadline)
                    Text(model.name ?? " ")
                        .foregroundColor(Colors.primaryTextColor)
                        .font(.headline)
                    Spacer()
                }
                HStack(spacing: 8) {
                    Text("BALANCE".localizedString)
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#9DA8C2"))
                    Text(model.balance.convertDecimals() + "SUM_UZS".localizedString)
                        .font(.headline)
                        .foregroundColor(model.balance >= 0 ? .green : .red)
                    Spacer()
                }
            }
            .padding()
            Spacer()
            VStack {
                Image("arrow-down")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
            }
        }
        .background(.white)
        .border(Colors.oldBorderColor, width: 0.5)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.2), radius: 2)
        .frame(height: 80)
        .padding(.horizontal, 20)
    }
}
