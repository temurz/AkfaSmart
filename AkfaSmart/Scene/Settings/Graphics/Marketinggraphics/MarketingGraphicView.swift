//
//  MarketinggraphicsView.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct MarketingItemViewModel {
    let title: String
    let value: String
}

struct MarketingGraphicsView: View {
    @ObservedObject var output: MarketingGraphicsViewModel.Output
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
        .navigationTitle("Marketing graphics")
        
    }
    
    init(viewModel: MarketingGraphicsViewModel) {
        let input = MarketingGraphicsViewModel.Input()
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
