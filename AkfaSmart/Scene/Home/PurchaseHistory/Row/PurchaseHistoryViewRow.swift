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
        VStack {
            HStack(spacing: 0) {
                Text("ORDER_WITH_NUMBER".localizedString)
                Text(String(model.cid ?? 0))
                Spacer()
                Text(model.date?.convertToDateUS() ?? "")
            }
            HStack(spacing: 0) {
                Text("CLIENT".localizedString)
                Text(model.dealerName ?? "")
                Spacer()
                Text(model.status ?? "")
                    .font(.subheadline)
                    .foregroundColor(Color.red)
                    .padding(4)
                    .background(Color(hex: "#FDE6E6"))
                    .cornerRadius(8)
            }
            HStack {
                Text((model.total?.convertDecimals() ?? "0") + " uzs")
                    .padding(.horizontal, 4)
                    .foregroundColor(type == .income ? .green : .red)
                Spacer()
                Button {
                    selectAction?()
                } label: {
                    Text("MORE".localizedString)
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color(hex: "#E7372C"))
                        .cornerRadius(4)
                }

            }
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray, lineWidth: 0.5)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}
