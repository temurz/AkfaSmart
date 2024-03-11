//
//  LanguageViewModel.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 16/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct LanguageItemViewModel: Hashable {
    let id: Int
    let title: String
    var isSelected: Bool = false
}

struct LanguageChangerView: View {
    @ObservedObject var output: LanguageChangerViewModel.Output
    private let saveTrigger = PassthroughSubject<Void,Never>()
    private let getCurrentLanguageTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    
    var body: some View {
        VStack (alignment: .leading) {
            List {
                ForEach($output.items, id: \.title) { $item in
                    LanguageViewRow(viewModel: item, selectedItem: $output.selectedRow)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            output.selectedRow = item
                        }
                    
                }
            }
            .listStyle(.plain)
            
        }
        .navigationTitle("LANGUAGE_TITLE".localizedString)
        .navigationBarItems(trailing: Button(action: {
            saveTrigger.send(())
        }, label: {
            Text("SAVE".localizedString)
                .foregroundColor(.red)
                .font(.headline)
        }))
        .onAppear {
            getCurrentLanguageTrigger.send(())
        }
    }
    
    init(viewModel: LanguageChangerViewModel) {
        let input = LanguageChangerViewModel.Input(
            saveTrigger: saveTrigger.asDriver(),
            getCurrentLanguageTrigger: getCurrentLanguageTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
