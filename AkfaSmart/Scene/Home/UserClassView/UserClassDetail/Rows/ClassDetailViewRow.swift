//
//  ClassDetailViewRow.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct ClassDetailViewRow: View {
    let model: MobileClassDetail
    @State var showDetails = false
    @State var showAmount = false
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("BY_ANNUAL_PURCHASE")
                    .padding()
                Spacer()
                Button {
                    showDetails.toggle()
                } label: {
                    if showDetails {
                        Image(systemName: "chevron.up")
                            .foregroundColor(Color.gray)
                            .padding()
                    }else {
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color.gray)
                            .padding()
                    }
                        
                }
            }
            .background(Color(hex: "#F6F8FC"))
            .cornerRadius(12, corners: [.topLeft, .topRight])
            if showDetails {
                Group {
                    Text(
                        ConverterToString.getStringFrom(model.c1KlassProductGroups)
                        + "TOTAL_OF_PRODUCTS_SHOULD_BE".localizedString
                        + ConverterToString.minMaxText(min: model.c1MinWeight, max: model.c1MaxWeight)
                    )
                        .padding()
                    HStack {
                        Spacer()
                        Text("PURCHASES_KG")
                            .underline(true)
                            .padding()
                            .onTapGesture {
                                showAmount.toggle()
                            }
                    }
                    if showAmount {
                        HStack(spacing: 0) {
                            Rectangle()
                                .frame(width: 1)
                                .edgesIgnoringSafeArea(.vertical)
                                .padding(.leading)
                            VStack(spacing: 0) {
                                ForEach(model.c1AmountDetail, id: \.id) {
                                    item in
                                    SeriesAndAmountRow(model: item)
                                }
                                Rectangle()
                                    .frame(height: 1)
                                    .edgesIgnoringSafeArea(.horizontal)
                                SeriesAndAmountRow(model: ClassAmountDetail(
                                    id: -1,
                                    name: "TOTAL".localizedString,
                                    amount: model.c1Amount))
                            }
                            .padding(.leading, 2)
                            
                        }
                        .padding()
                    }
                    if !model.c2ObjectList.isEmpty {
                        VStack(spacing: 0) {
                            HStack {
                                Text("ADDITIONAL_TERMS")
                                Spacer()
                            }
                            .padding(.leading)
                            ForEach(model.c2ObjectList, id: \.c2Id) {
                                item in
                                AdditionalClassDetailRow(model: item)
                                    .padding()
                            }
                        }
                        .padding()
                    }
                }
                .background(Color.white)
            }
        }
        .background(.white)
        .border(Color(hex: "#E2E5ED"), width: 0.5)
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
    
}
