//
//  EditInfographicsViewRow.swift
//  AkfaSmart
//
//  Created by Temur on 12/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct EditInfographicsViewRow: View {
    let title: String
    let constantModel: String?
    @Binding var editedValue: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal, 4)
            Text(constantModel ?? "")
                .font(.subheadline)
                .padding(.horizontal, 4)
            TextField(editedValue, text: $editedValue)
                .foregroundStyle(.red)
                .frame(height: 48)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 8))
                .background(Color(hex: "#F5F7FA"))
                .cornerRadius(12)
        }
        .padding(.horizontal)
    }
}
