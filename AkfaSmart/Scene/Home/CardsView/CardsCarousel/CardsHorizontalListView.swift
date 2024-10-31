//
//  CardsHorizontalListView.swift
//  AkfaSmart
//
//  Created by Temur on 21/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct CardsHorizontalListView: View {
    @Binding var data: [Card]
    var didSelectCard: (Card) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(data, id: \.id) { model in
                CardRowView(model: model)
                    .onTapGesture {
                        didSelectCard(model)
                    }
            }
        }
    }
}
