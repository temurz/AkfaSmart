//
//  HRgraphicsView.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//


import SwiftUI

struct HRItemViewModel {
    let title: String
    let value: String
}

struct HRgraphicsView: View {
    @ObservedObject var output: HRgraphicsViewModel.Output
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: .constant(false), text: .constant("")) {
            VStack {
                List {
                    ForEach(output.items, id: \.title) { item in
                        HRViewRow(viewModel: item)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("HR graphics")
       
    }
    
    init(viewModel: HRgraphicsViewModel) {
        let input = HRgraphicsViewModel.Input()
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

#Preview {
    HRgraphicsView(viewModel: HRgraphicsViewModel())
}
