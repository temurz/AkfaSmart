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
        VStack {
            
            HStack {
                Text("By Annual purchase")
                Spacer()
                Button {
                    showDetails.toggle()
                } label: {
                    if showDetails {
                        Image(systemName: "chevron.up")
                    }else {
                        Image(systemName: "chevron.down")
                    }
                }
            }
            .padding(.vertical)
            if showDetails {
                Text("\(ConverterToString.getStringFrom(model.c1KlassProductGroups)) mahsulotlarning ja'mi xaridi \(minMaxText(min: model.c1MinWeight, max: model.c1MaxWeight)) bo'lishi kerak")
                HStack {
                    Spacer()
                    Text("Xaridlar(kg)")
                        .underline(true)
                        .onTapGesture {
                            showAmount.toggle()
                        }
                }
                VStack {
                    
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func minMaxText(min: Double, max: Double) -> String {
        if min == 0 {
            return "eng kamida \(max)"
        }else {
            return "eng ko'pi \(min)"
        }
    }
}
