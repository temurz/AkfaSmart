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
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.footnote)
                    .foregroundStyle(Colors.textSteelColor)
                Text(viewModel.value)
                    .font(.body)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .lineLimit(Int.max)
                Text(viewModel.editedValue)
                    .font(.body)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .lineLimit(Int.max)
                    .foregroundColor(.red)
            }
            .padding(.horizontal)
            Divider()
        }
        
    }
}
