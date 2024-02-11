//
//  InfographicsView.swift
//  AkfaSmart
//
//  Created by Temur on 11/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct InfoItemViewModel {
    let title: String
    let value: String
}

struct InfographicsView: View {
    @ObservedObject var output: InfographicsViewModel.Output
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: .constant(false), text: .constant("")) {
            VStack {
                List {
                    ForEach(output.items, id: \.title) { item in
                        InfoViewRow(viewModel: item)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Infographics")
        .navigationBarItems(trailing: Button(action: {
            
        }, label: {
            Text("Edit")
                .foregroundColor(.red)
                .font(.headline)
        }))
    }
    
    init(viewModel: InfographicsViewModel) {
        let input = InfographicsViewModel.Input()
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

#Preview {
    InfographicsView(viewModel: InfographicsViewModel())
}
