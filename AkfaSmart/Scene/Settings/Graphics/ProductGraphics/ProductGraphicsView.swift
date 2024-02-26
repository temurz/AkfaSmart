//
//  SecretgraphicsView.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct ProductGraphicsView: View {
    @ObservedObject var output: ProductGraphicsViewModel.Output
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: .constant(false), text: .constant("")) {
            VStack {
                List {
                    ForEach(output.items, id: \.title) { item in
                        MarketingViewRow(viewModel: item)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Secretgraphics")
        
    }
    
    init(viewModel: ProductGraphicsViewModel) {
        let input = ProductGraphicsViewModel.Input()
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
