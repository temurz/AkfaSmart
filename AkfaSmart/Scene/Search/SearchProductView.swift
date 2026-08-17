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
    @State private var isGroupPickerPresented = false
    @State private var addToCartSheetHeight: CGFloat = 260
    private let loadProductsTrigger = PassthroughSubject<SearchProductQuery,Never>()
    private let reloadProductsTrigger = PassthroughSubject<SearchProductQuery,Never>()
    private let loadMoreProductsTrigger = PassthroughSubject<SearchProductQuery,Never>()
    private let showLocationTrigger = PassthroughSubject<ProductWithName,Never>()
    private let selectProductTrigger = PassthroughSubject<ProductWithName,Never>()
    private let addToCartTrigger = PassthroughSubject<(ProductWithName, Int),Never>()
    private let dismissAddToCartTrigger = PassthroughSubject<Void,Never>()
    private let showCartTrigger = PassthroughSubject<Void,Never>()
    private let loadGroupsTrigger = PassthroughSubject<Void,Never>()
    private let selectGroupTrigger = PassthroughSubject<ProductGroup?,Never>()

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
                                    loadProductsTrigger.send(SearchProductQuery(text: "", groupId: output.selectedGroup?.id))
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
                    .padding(.horizontal)
                    .padding(.top)

                    HStack {
                        Button {
                            isGroupPickerPresented = true
                        } label: {
                            HStack(spacing: 6) {
                                Text(output.selectedGroup?.text ?? "SELECT_GROUP".localizedString)
                                    .font(.system(size: 13))
                                    .foregroundColor(output.selectedGroup == nil ? Colors.secondaryTextColor : Colors.primaryTextColor)
                                    .lineLimit(1)
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 11))
                                    .foregroundColor(Colors.secondaryTextColor)
                            }
                            .padding(.horizontal, 12)
                            .frame(height: 32)
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Colors.oldBorderColor)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)

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
                                                loadMoreProductsTrigger.send(SearchProductQuery(text: output.searchedText, groupId: output.selectedGroup?.id))
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
                    loadProductsTrigger.send(SearchProductQuery(text: "", groupId: output.selectedGroup?.id))
                    loadGroupsTrigger.send(())
                }
            }

            if isGroupPickerPresented {
                ProductGroupPickerSheetView(
                    rootGroups: output.groups,
                    onSelect: { group in
                        selectGroupTrigger.send(group)
                        isGroupPickerPresented = false
                    },
                    onDismiss: { isGroupPickerPresented = false }
                )
            }
        }
        .sheet(item: $output.selectedProduct, onDismiss: { dismissAddToCartTrigger.send(()) }) { product in
            AddToCartSheetView(
                product: product,
                onAdd: { quantity in addToCartTrigger.send((product, quantity)) }
            )
            .readSheetHeight(into: $addToCartSheetHeight)
            .presentationDetents([.height(addToCartSheetHeight)])
            .presentationDragIndicator(.visible)
            .presentationCompactAdaptation(.sheet)
            .presentationBackground(Color.white)
        }
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
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
            showCartTrigger: showCartTrigger.asDriver(),
            loadGroupsTrigger: loadGroupsTrigger.asDriver(),
            selectGroupTrigger: selectGroupTrigger.asDriver())

        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
