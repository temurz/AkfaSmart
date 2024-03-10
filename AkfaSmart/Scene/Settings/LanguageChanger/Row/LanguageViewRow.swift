//
//  LanguageViewRow.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 16/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct LanguageViewRow: View {
    var viewModel: LanguageItemViewModel
    @Binding var selectedItem: LanguageItemViewModel?
    var body: some View {
        VStack(alignment: .leading) {

            HStack{
                if viewModel == selectedItem {
                    Text(viewModel.title)
                        .foregroundColor(.red)
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(.red)
                    
                }else {
                    Text(viewModel.title)
                        .foregroundColor(.black)
                }
            }
            
        }
    }
}

#Preview {
    LanguageViewRow(viewModel: LanguageItemViewModel(id: 0, title: ""), selectedItem: .constant(nil))
}
