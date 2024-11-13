//
//  PaymentHistoryViewRow.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct PaymentHistoryViewRow: View {
    var model: PaymentReceipt
    var type: PaymentHistoryType
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack(spacing: 0) {
                    Text(model.dealerName ?? "")
                        .font(.body)
                        .bold()
                    Spacer()
                    
                }
                HStack(spacing: 0) {
                    Text(type == .receipt ? model.fromClientName ?? "" : model.toClientName ?? "")
                        .font(.body)
                        .foregroundStyle(Colors.textDescriptionColor)
                    Spacer()
                    Text((model.amount?.convertDecimals() ?? "") + " uzs")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(type == .receipt ? .green : .red)
                        .padding(4)
                        .background(type == .receipt ? Colors.customGreenBackgroundColor.opacity(0.2) : Colors.customRedColor.opacity(0.2))
                        .cornerRadius(7, corners: .allCorners)
                }

            }
            .padding()
            Colors.borderGrayColor
                .frame(height: 1)
            VStack {
                HStack {
                    Spacer()
                    Text(Date(timeIntervalSince1970: TimeInterval(model.date ?? 1)/1000.0).convertToDateUS())
                        .font(.footnote)
                        .foregroundStyle(Colors.textSteelColor)
                        .padding()
                }
            }
        }
        .background(.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        
    }
}
