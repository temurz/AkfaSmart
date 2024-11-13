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
        VStack {
            VStack {
                HStack(spacing: 0) {
                    Text("CLIENT".localizedString)
                    Text(model.dealerName ?? "")
                        .bold()
                    Spacer()
                    Text(Date(timeIntervalSince1970: TimeInterval(model.date ?? 1)/1000.0).convertToDateUS())
                        .foregroundColor(Color(hex: "#9DA8C2"))
                }
                .padding(.vertical, 4)
                HStack(spacing: 0) {
                    Text(model.fromClientName ?? "")
                    Spacer()
                }
                .padding(.vertical, 4)
                HStack {
                    Text(model.toClientName ?? "")
                        .font(.subheadline)
                        .padding(.horizontal)
                    Spacer()
                    Text((model.amount?.convertDecimals() ?? "") + " uzs")
                        .bold()
                        .foregroundColor(type == .receipt ? .green : .red)
                        .padding(.horizontal)
                }
                .padding(.vertical, 4)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 0.5)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
            
            Color(hex: "#DFE3EB")
                .frame(height: 3)
        }
        .background(.white)
    }
}
