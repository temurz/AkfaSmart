//
//  SearchProductRow.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct SearchProductRow: View {
    var model: ProductWithName
    
    var selected: (() -> Void)?
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(model.name)
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "#9497A1"))
                HStack(spacing: 0) {
                    Text("Guruh: ")
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#9497A1"))
                    Spacer()
                    Text(model.groupName)
                }
                
                HStack {
                    Text("Narxi: ")
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#9497A1"))
                    Spacer()
                    Text(model.rate.convertDecimals() + " uzs")
                }
            }
            .padding()
            
            Divider()
            HStack {
                Spacer()
                Image("arrow_forward")
                    .padding(.bottom, 8)
            }
            .background(Color.white)
            .padding(.horizontal)
            .onTapGesture {
                selected?()
            }
        }
        .background(.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}
