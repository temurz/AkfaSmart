//
//  TechnographicsView.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct TechnoItemViewModel {
    let title: String
    let value: String
}

struct TechnographicsView: View {
    @ObservedObject var output: TechnographicsViewModel.Output
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: .constant(false), text: .constant("")) {
            VStack {
                List {
                    ForEach(output.items, id: \.title) { item in
                        TechnoViewRow(viewModel: item)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Technographics")
        
    }
    
    init(viewModel: TechnographicsViewModel) {
        let input = TechnographicsViewModel.Input()
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
