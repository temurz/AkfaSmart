//
//  DealersListView.swift
//  AkfaSmart
//
//  Created by Temur on 21/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct DealersListView: View {
    @Binding var data: [Dealer]
    @Binding var isBalanceVisible: Bool
    @Binding var totalOfMonth: Double
    @Binding var totalOfYear: Double
    var openPurchases: ((Int) -> ())
    var openPayments: ((Int) -> ())
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(data, id: \.dealerClientCid) { model in
                DealerViewRow(
                    width: UIScreen.main.bounds.width,
                    model: model,
                    isBalanceVisible: self.isBalanceVisible,
                    totalOfMonth: $totalOfMonth,
                    totalOfYear: $totalOfYear,
                    openPurchases: openPurchases,
                    openPayments: openPayments
                )
            }
        }
    }
}
