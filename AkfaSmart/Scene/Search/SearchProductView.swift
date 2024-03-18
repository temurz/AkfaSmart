//
//  CreateOrderView.swift
//  AkfaSmart
//
//  Created by Temur on 06/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct SearchProductView: View {
    @ObservedObject var output: SearchProductViewModel.Output
    private let loadProductsTrigger = PassthroughSubject<String,Never>()
    private let reloadProductsTrigger = PassthroughSubject<String,Never>()
    private let loadMoreProductsTrigger = PassthroughSubject<String,Never>()
    private let showProductDetailView = PassthroughSubject<ProductWithName,Never>()
    
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                ZStack(alignment: .trailing) {
                    TextField("SEARCH".localizedString, text: $output.searchedText)
                        .frame(height: 48)
                        .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 8))
                        .background(Color(hex: "#F5F7FA"))
                        .cornerRadius(12)
                        .padding()
                    
                    Image(systemName: "magnifyingglass")
                        .padding()
                        .padding(.trailing, 8)
//                        .resizable()
//                        .frame(width: 24, height: 24)
                }
                
                if output.items.isEmpty {
                    VStack(alignment: .center) {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("LIST_IS_EMPTY".localizedString)
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                        Spacer()
                    }
                }else {
                    List {
                        ForEach(output.items, id: \.id) { item in
                            SearchProductRow(model: item) {
                                showProductDetailView.send(item)
                            }
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("SEARCH_PRODUCT".localizedString)
            .navigationBarHidden(false)
        }
    }
    
    init(viewModel: SearchProductViewModel) {
        let input = SearchProductViewModel.Input(
            loadProductsTrigger: loadProductsTrigger.asDriver(),
            reloadProductsTrigger: reloadProductsTrigger.asDriver(),
            loadMoreProductsTrigger: loadMoreProductsTrigger.asDriver(),
            showProductDetailView: showProductDetailView.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
