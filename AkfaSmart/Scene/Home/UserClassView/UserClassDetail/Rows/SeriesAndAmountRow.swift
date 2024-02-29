//
//  SeriesAndAmountRow.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct SeriesAndAmountRow: View {
    var model: ClassAmountDetail
    var body: some View {
        HStack {
            Text(model.name ?? "")
                .font(.system(size: 14))
            Spacer()
            Text(String(format: "%.2f", model.amount ?? 0))
                .font(.system(size: 16))
        }
    }
}
