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
    var didSelectInformation: (Dealer) -> ()
    var addDealerAction: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(data, id: \.dealerClientCid) { model in
                if model.dealerId != nil {
                    DealerViewRow(
                        model: model,
                        didSelectInformation: didSelectInformation
                    )
                } else {
                    DealerViewRow(addRow: true, addDealerAction: addDealerAction)
                }   
            }
        }
    }
}
