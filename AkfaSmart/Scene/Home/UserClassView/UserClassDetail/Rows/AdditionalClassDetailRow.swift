//
//  AdditionalClassDetailRow.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct AdditionalClassDetailRow: View {
    var model: AdditionalClassDetail
    @State var showAmount = false
    var body: some View {
        VStack {
            Text("* (\("\(ConverterToString.getStringFrom(model.c2KlassProductGroups)) mahsulotlarning ja'mi xaridi eng ko'pi \(model.c2Percent) % bo'lishi kerak")")
            HStack {
                Spacer()
                Text("Xaridlar(kg)")
                    .underline(true)
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
                        Text("\(ConverterToString.getStringFrom(model.c2KlassProductGroups))")
                            .font(.system(size: 16))
                        Rectangle()
                            .frame(height: 1)
                            .edgesIgnoringSafeArea(.horizontal)
                        SeriesAndAmountRow(model: ClassAmountDetail(id: -1, name: "Jami", amount: model.c2Amount))
                    }
                    .padding(.leading, 2)
                }
                .padding()
            }
        }
    }
}
