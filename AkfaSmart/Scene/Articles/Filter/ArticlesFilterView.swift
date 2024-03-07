//
//  ArticlesFilterView.swift
//  AkfaSmart
//
//  Created by Temur on 07/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import UIKit
struct ArticlesFilterView: View {
    @EnvironmentObject var dateFilter: DateFilter
    @EnvironmentObject var type: ArticleObservableType
    @ObservedObject var output: ArticlesFilterViewModel.Output
    var navigationController: UINavigationController
    
    private let getArticleTypesTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    
    var body: some View {
        return LoadingView(isShowing: .constant(false), text: .constant("")) {
            VStack {
                HStack {
                    Text("Type of Article")
                        .padding()
                    Spacer()
                    Picker("Select article type", selection: $output.selectedType) {
                        ForEach(output.types, id: \.self) { type in
                            Text(type.name ?? "")
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal)
                
                CalendarAlert(from: dateFilter.from, to: dateFilter.to) { from, to in
                    dateFilter.from = from
                    dateFilter.to = to
                    dateFilter.optionalFrom = from
                    dateFilter.optionalTo = to
                    if let id = output.selectedType.id {
                        type.type = "\(id)"
                    }
                    dateFilter.isFiltered = true
                    navigationController.popViewController(animated: true)
                }
                Spacer()
            }
        }
        .navigationTitle("Filter")
        .navigationBarItems(trailing:
                                Button(action: {
            dateFilter.optionalFrom = nil
            dateFilter.optionalTo = nil
            dateFilter.isFiltered = true
            type.type = nil
            navigationController.popViewController(animated: true)
        }, label: {
            Text("Clear")
                .foregroundColor(.red)
        })
        )
        .onAppear {
            getArticleTypesTrigger.send(())
        }
    }
    
    init(viewModel: ArticlesFilterViewModel, navigationController: UINavigationController) {
        let input = ArticlesFilterViewModel.Input(getArticleTypesTrigger: getArticleTypesTrigger.asDriver())
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        self.navigationController = navigationController
    }
}
