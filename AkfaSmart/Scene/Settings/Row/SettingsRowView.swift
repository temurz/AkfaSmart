//
//  SettingsRowView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct SettingsRowView: View {
    let viewModel: SettingItemViewModel
    var body: some View {
        HStack {
            if !viewModel.image.isEmpty {
                Image(viewModel.image)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            Text(viewModel.text)
                .font(.body)
                .bold()
                .padding(.leading, 4)
            Spacer()
            if viewModel.id != 0 {
                Image(systemName: "chevron.forward")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color(hex: "#979797"))
                    .frame(width: 12, height: 12)
            }
        }
        .padding()
    }
}
