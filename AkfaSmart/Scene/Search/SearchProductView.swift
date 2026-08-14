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
    private let showLocationTrigger = PassthroughSubject<ProductWithName,Never>()
    private let selectProductTrigger = PassthroughSubject<ProductWithName,Never>()
    private let addToCartTrigger = PassthroughSubject<(ProductWithName, Int),Never>()
    private let dismissAddToCartTrigger = PassthroughSubject<Void,Never>()
    private let showCartTrigger = PassthroughSubject<Void,Never>()

    private let cancelBag = CancelBag()
    var body: some View {
        return ZStack {
            LoadingView(isShowing: $output.isLoading, text: .constant("")) {
                VStack {
                    ModuleNavigationBar(title: "SEARCH_PRODUCT".localizedString)
                    HStack {
                        ZStack(alignment: .trailing) {
                            TextField("SEARCH".localizedString, text: $output.searchedText)
                                .onSubmit {
                                    loadProductsTrigger.send("")
                                }
                                .frame(height: 48)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 8))
                                .background(Color(hex: "#F5F7FA"))
                                .cornerRadius(12)

                            Image(systemName: "magnifyingglass")
                                .padding(.trailing, 8)
                        }

                        Button {
                            showCartTrigger.send(())
                        } label: {
                            ZStack(alignment: .topTrailing) {
                                Image(systemName: "cart")
                                    .foregroundColor(Colors.primaryTextColor)
                                    .frame(width: 24, height: 24)
                                if output.cartCount > 0 {
                                    Text("\(output.cartCount)")
                                        .font(.system(size: 11))
                                        .foregroundColor(.white)
                                        .padding(4)
                                        .background(Colors.customRedColor)
                                        .clipShape(Circle())
                                        .offset(x: 10, y: -10)
                                }
                            }
                        }
                    }
                    .padding()

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
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                                ForEach(output.items, id: \.id) { item in
                                    SearchProductRow(
                                        model: item,
                                        onSelectCard: { selectProductTrigger.send(item) },
                                        onSelectLocation: { showLocationTrigger.send(item) }
                                    )
                                        .onAppear {
                                            if output.items.last?.id ?? -1 == item.id && output.hasMorePages {
                                                loadMoreProductsTrigger.send(output.searchedText)
                                            }
                                        }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)

                            if output.isLoadingMore {
                                ActivityIndicator(isAnimating: $output.isLoadingMore, style: .large)
                                    .padding()
                            }
                        }
                    }
                }
                .navigationBarHidden(true)
                .onAppear {
                    loadProductsTrigger.send("")
                }
            }

            if let selectedProduct = output.selectedProduct {
                AddToCartSheetView(
                    product: selectedProduct,
                    onAdd: { quantity in addToCartTrigger.send((selectedProduct, quantity)) },
                    onDismiss: { dismissAddToCartTrigger.send(()) }
                )
            }
        }
    }

    init(viewModel: SearchProductViewModel) {
        let input = SearchProductViewModel.Input(
            loadProductsTrigger: loadProductsTrigger.asDriver(),
            reloadProductsTrigger: reloadProductsTrigger.asDriver(),
            loadMoreProductsTrigger: loadMoreProductsTrigger.asDriver(),
            showLocationTrigger: showLocationTrigger.asDriver(),
            selectProductTrigger: selectProductTrigger.asDriver(),
            addToCartTrigger: addToCartTrigger.asDriver(),
            dismissAddToCartTrigger: dismissAddToCartTrigger.asDriver(),
            showCartTrigger: showCartTrigger.asDriver())

        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
