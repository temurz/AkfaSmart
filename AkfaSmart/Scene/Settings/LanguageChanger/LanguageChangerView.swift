//
//  LanguageViewModel.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 16/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct LanguageItemViewModel: Hashable {
  
    let title: String
    var isSelected: Bool = false
}

struct LanguageChangerView: View {
    @ObservedObject var output: LanguageChangerViewModel.Output
    private let cancelBag = CancelBag()
    
    @State private var selectedRow: LanguageItemViewModel?
    
    var body: some View {
        
        return LoadingView(isShowing: .constant(false), text: .constant("")) {
            VStack (alignment: .leading) {
                List {
                    ForEach($output.items, id: \.title) { $item in
                        LanguageViewRow(viewModel: item,selectedItem: $selectedRow)
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                selectedRow = item
                               
                            }
                        
                    }
                }
                .listStyle(.plain)
                
            }
        }
        .navigationTitle("Language")
        .navigationBarItems(trailing: Button(action: {
            
            
            
        }, label: {
            Text("Save")
                .foregroundColor(.red)
                .font(.headline)
        }))
    }
    
    init(viewModel: LanguageChangerViewModel) {
        let input = LanguageChangerViewModel.Input()
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

#Preview {
    LanguageChangerView(viewModel: LanguageChangerViewModel())
}
