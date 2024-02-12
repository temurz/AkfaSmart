//
//  InfoViewRow.swift
//  AkfaSmart
//
//  Created by Temur on 11/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct InfoViewRow: View {
    let viewModel: InfoItemViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title)
                .foregroundColor(Color(hex: "#9DA8C2"))
            Text(viewModel.value)
                .lineLimit(0)
        }
    }
}

#Preview {
    InfoViewRow(viewModel: InfoItemViewModel(title: "", value: ""))
}
