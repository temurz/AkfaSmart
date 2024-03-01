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
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Text("Buyurtma №")
                Text(String(model.cid))
                Spacer()
                Text("\(model.date.convertToDateUS())")
            }
            HStack(spacing: 0) {
                Text("Mijoz: ")
                Text("\(model.dealerName)")
                Spacer()
                Text("\(model.status)")
                    .font(.subheadline)
                    .foregroundColor(Color.red)
                    .padding(4)
                    .background(Color(hex: "#FDE6E6"))
                    .cornerRadius(8)
            }
            HStack {
                Text(String(format: "%.2f", model.total) + " uzs")
                    .padding(.horizontal)
                    .foregroundColor(type == .income ? .green : .red)
                Spacer()
                Button {
                    
                } label: {
                    Text("Batafsil")
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color(hex: "#E7372C"))
                        .cornerRadius(8)
                }

            }
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 0.5)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}
