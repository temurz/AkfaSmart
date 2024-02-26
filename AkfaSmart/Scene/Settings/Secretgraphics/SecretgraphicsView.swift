//
//  SecretgraphicsView.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct SecretItemViewModel {
    let title: String
    let value: String
}

struct SecretgraphicsView: View {
    @ObservedObject var output: SecretgraphicsViewModel.Output
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: .constant(false), text: .constant("")) {
            VStack {
                List {
                    ForEach(output.items, id: \.title) { item in
                        SecretViewRow(viewModel: item)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Secretgraphics")
        
    }
    
    init(viewModel: SecretgraphicsViewModel) {
        let input = SecretgraphicsViewModel.Input()
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
