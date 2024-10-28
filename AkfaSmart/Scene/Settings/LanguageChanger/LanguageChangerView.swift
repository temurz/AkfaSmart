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
    private let popViewControllerTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    
    var body: some View {
        VStack (alignment: .leading) {
            CustomNavigationBar(title: "LANGUAGE_TITLE".localizedString, rightBarTitle: "SAVE".localizedString) {
                popViewControllerTrigger.send(())
            } onRightBarButtonTapAction: {
                saveTrigger.send(())
            }

            List {
                ForEach($output.items, id: \.title) { $item in
                    LanguageViewRow(viewModel: item, selectedItem: $output.selectedRow)
                        .listRowSeparator(.hidden)
                        .background(Color.white)
                        .onTapGesture {
                            output.selectedRow = item
                        }
                    
                }
            }
            .listStyle(.plain)
            
        }
        .onAppear {
            getCurrentLanguageTrigger.send(())
        }
    }
    
    init(viewModel: LanguageChangerViewModel) {
        let input = LanguageChangerViewModel.Input(
            saveTrigger: saveTrigger.asDriver(),
            getCurrentLanguageTrigger: getCurrentLanguageTrigger.asDriver(),
            popViewControllerTrigger: popViewControllerTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
