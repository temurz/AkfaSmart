//
//  ProductDealerViewRow.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct ProductDealerViewRow: View {
    var model: ProductDealerWithLocation
    var selectLocation: (() -> Void)?
    var selectPhone: (() -> Void)?
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(model.dealerName)
                .font(.bold(.headline)())
                .padding(.horizontal)
                .padding(.vertical, 8)
            Divider()
            HStack {
                Image("location")
                Text("\(model.address)")
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            Divider()
            HStack {
                HStack {
                    Image("routing-2")
                        .padding(.leading)
                    Divider()
                    Text(String(format: "%.1f", model.distance/1000) + "\nkm")
                        .fixedSize()
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.trailing)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.gray, lineWidth: 0.5)
                }
                .padding(.vertical)
                Spacer()
                Button {
                    selectLocation?()
                } label: {
                    Image("location_white")
                        .frame(minWidth: 40)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(14)
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
                Button {
                    selectPhone?()
                } label: {
                    Image("call-calling")
                        .frame(minWidth: 40)
                        .padding()
                        .background(Color(hex: "#35AC81"))
                        .cornerRadius(14)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
        }
        .listRowBackground(Color.clear)
        .background(.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}
