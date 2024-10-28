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
                CustomNavigationBar(title: "FILTER".localizedString, rightBarTitle: "CLEAR".localizedString) {
                    navigationController.popViewController(animated: true)
                } onRightBarButtonTapAction: {
                    dateFilter.optionalFrom = nil
                    dateFilter.optionalTo = nil
                    dateFilter.isFiltered = true
                    type.type = nil
                    type.name = nil
                    navigationController.popViewController(animated: true)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("ARTICLE_NAME".localizedString)
                        .padding(.horizontal, 4)
                    TextField("ARTICLE_NAME".localizedString, text: $output.articleName)
                        .frame(height: 48)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 8))
                        .background(Color(hex: "#F5F7FA"))
                        .cornerRadius(12)
                }
                .padding([.horizontal, .top])
                
                CalendarAlert(from: dateFilter.from, to: dateFilter.to)
                    .environmentObject(dateFilter)
                
                types
                
                Button(action: {
                    dateFilter.isFiltered = true
                    if let id = output.selectedType.id {
                        type.type = "\(id)"
                    }
                    if !output.articleName.isEmpty {
                        type.name = output.articleName
                    }
                    navigationController.popViewController(animated: true)
                }) {
                    HStack{
                        
                        Text("FILTER".localizedString)
                            .font(.headline)
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .foregroundColor(Color.white)
                            .background(Color.red)
                            .cornerRadius(12)
                            .padding(.top, 16)
                    }
                }.padding()
                
                Spacer()
            }
        }
        .onAppear {
            getArticleTypesTrigger.send(())
        }
    }
    
    
    var types: some View {
        HStack {
            Text("TYPE_OF_ARTICLES".localizedString)
                .padding()
            Spacer()
            Picker("SELECT_ARTICLE_TYPE".localizedString, selection: $output.selectedType) {
                ForEach(output.types, id: \.self) { type in
                    Text(type.name ?? "")
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding(.horizontal)
    }
    
    init(viewModel: ArticlesFilterViewModel, navigationController: UINavigationController) {
        let input = ArticlesFilterViewModel.Input(getArticleTypesTrigger: getArticleTypesTrigger.asDriver())
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        self.navigationController = navigationController
    }
}
