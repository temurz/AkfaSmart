//
//  PurchaseHistoryViewRow.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct PurchaseHistoryViewRow: View {
    var model: Invoice
    var type: PurchaseHistoryType
    var selectAction: (() -> Void)?
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack(spacing: 0) {
                    Text("ORDER_WITH_NUMBER".localizedString)
                        .font(.footnote)
                        .foregroundStyle(Colors.textSteelColor)
                        .padding(.trailing)
                    Text(String(model.cid ?? 0))
                        .font(.body)
                        .bold()
                        .foregroundStyle(Colors.textDescriptionColor)
                    Spacer()
                }
                HStack(spacing: 0) {
                    Text("DEALER".localizedString)
                        .font(.footnote)
                        .foregroundStyle(Colors.textSteelColor)
                        .padding(.trailing)
                    Text(model.dealerName ?? "")
                        .font(.body)
                        .bold()
                        .foregroundStyle(Colors.textDescriptionColor)
                    Spacer()
                }
                HStack {
                    Text((model.total?.convertDecimals() ?? "0") + " uzs")
                        .font(.footnote)
                        .bold()
                        .padding(4)
                        .foregroundStyle(type == .income ? .green : .red)
                        .background(Colors.customGreenBackgroundColor.opacity(0.1))
                        .cornerRadius(7, corners: .allCorners)
                    Spacer()
                    Text(Date(timeIntervalSince1970: TimeInterval(model.date ?? 1)/1000.0).convertToDateUS())
                        .font(.footnote)
                        .foregroundStyle(Colors.textSteelColor)
                }
            }
            .padding()
            Colors.borderGrayColor
                .frame(height: 1)
            VStack {
                Button {
                    selectAction?()
                } label: {
                    Text("MORE".localizedString)
                        .bold()
                        .foregroundColor(Colors.customRedColor)
                        .padding(16)
                }
            }
        }
        .background(.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}
