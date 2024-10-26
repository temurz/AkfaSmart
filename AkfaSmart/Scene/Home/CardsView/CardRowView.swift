//
//  CardViewRow.swift
//  AkfaSmart
//
//  Created by Temur on 21/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct CardRowView: View {
    var model: Card
    var isAddRow = false
    
    init(model: Card) {
        self.model = model
    }
    
    init(isAddRow: Bool) {
        self.isAddRow = isAddRow
        self.model = Card()
    }
    
    var body: some View {
        VStack {
            VStack {
                if isAddRow {
                    HStack {
                        Spacer()
                        Image(systemName: "plus.app")
                            .resizable()
                            .foregroundStyle(Colors.customRedColor)
                            .frame(width: 24, height: 24)
                        Text("ADD_CARD".localizedString)
                            .font(.headline)
                            .foregroundStyle(Colors.customRedColor)
                        Spacer()
                    }
                    .frame(height: 140)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(hex: "#E2E5ED"), lineWidth: 1)
                    }
                } else {
                    ZStack {
                        gradient(colors: model.getColorStrings().map({ Color(hex: $0) }), startPoint: .bottomLeading, endPoint: .topTrailing)
                        HStack {
                            Text("BONUS_CARD".localizedString)
                                .font(.subheadline)
                                .foregroundStyle(Color.white)
                                .padding()
                            Spacer()
                            Image("more_vert")
                                .renderingMode(.template)
                                .resizable()
                                .foregroundStyle(.white)
                                .frame(width: 24, height: 24)
                                .padding()
                        }
                    }
                    .cornerRadius(12, corners: .allCorners)
                    
                }
                
            }
            .frame(height: 140)
            .padding(.horizontal)
            
        }
        .frame(height: 140)
        .frame(width: UIScreen.main.bounds.width)
    }
}
