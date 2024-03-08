//
//  PurchaseDetailViewRow.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct PurchaseDetailViewRow: View {
    var model: InvoiceDetail
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(model.productName ?? "")
                        .foregroundColor(Color(hex: "#51526C"))
                    Spacer()
                    Text(model.status ?? "")
                        .font(.subheadline)
                        .foregroundColor(Color.red)
                        .padding(4)
                        .background(Color(hex: "#FDE6E6"))
                        .cornerRadius(8)
                }
                HStack {
                    Text("Miqdori: ")
                        .font(.footnote)
                    Spacer()
                    Text(String(format: "%.0f", (model.qty ?? 0)))
                }
                HStack {
                    Text("Narxi: ")
                        .font(.footnote)
                    Spacer()
                    Text((model.rate?.convertDecimals() ?? "0") + " uzs")
                }
                HStack {
                    Text("Jami: ")
                        .font(.footnote)
                    Spacer()
                    Text((model.amount?.convertDecimals() ?? "0") + " uzs")
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 2)
            .padding(.top, 8)
            
            Divider()
        }
        
    }
}
