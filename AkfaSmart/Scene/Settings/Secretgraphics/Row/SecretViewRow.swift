//
//  SecretViewRow.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct SecretViewRow: View {
    let viewModel: SecretItemViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title)
                .foregroundColor(Color(hex: "#9DA8C2"))
            Text(viewModel.value)
        }
    }
}
