//
//  PurchaseHistoryView.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import SwiftUIRefresh
struct PurchaseHistoryView: View {
    @ObservedObject var output: PurchaseHistoryViewModel.Output
    @State var selection = 0
    private let loadIncome = PassthroughSubject<InvoiceInput,Never>()
    private let reloadIncome = PassthroughSubject<InvoiceInput,Never>()
    private let loadMoreIncome = PassthroughSubject<InvoiceInput,Never>()
    private let showFilterViewTrigger = PassthroughSubject<Void,Never>()
    private let showDetailViewTrigger = PassthroughSubject<Invoice, Never>()
    
    private let popViewControllerTrigger = PassthroughSubject<Void, Never>()

    private let cancelBag = CancelBag()
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "PURCHASE_HISTORY_TITLE".localizedString, rightBarImage: "filter_icon") {
                    popViewControllerTrigger.send(())
                } onRightBarButtonTapAction: {
                    showFilterViewTrigger.send(())
                }

                Picker("", selection: $selection) {
                    Text("INCOME".localizedString)
                        .font(.headline)
                        .padding()
                        .tag(0)
                    Text("OUTCOME".localizedString)
                        .font(.headline)
                        .padding()
                        .tag(1)
                }
                .pickerStyle(.segmented)
                .frame(height: 32)
                .padding()
                .onChange(of: selection) { tag in
                    output.type = tag == 0 ? .income : .returnType
                    output.items = []
                    loadIncome.send(InvoiceInput(from: output.dateFilter.optionalFrom, to: output.dateFilter.optionalTo, type: output.type.rawValue))
                }
                if output.items.isEmpty && !output.isLoading {
                    VStack(alignment: .center) {
                        Spacer()
                        Text("LIST_IS_EMPTY".localizedString)
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                }else {
                    List {
                        ForEach(output.items, id: \.cid) { item in
                            PurchaseHistoryViewRow(model: item, type: output.type) {
                                showDetailViewTrigger.send(item)
                            }
                                .onAppear {
                                    if output.items.last?.cid == item.cid && output.hasMorePages {
                                        output.isLoadingMore = true
                                        loadMoreIncome.send(InvoiceInput(from: output.dateFilter.optionalFrom, to: output.dateFilter.optionalTo, type: output.type.rawValue))
                                    }
                                }
                                .listRowSeparator(.hidden)
                        }
                        if output.isLoadingMore {
                            HStack {
                                Spacer()
                                ActivityIndicator(isAnimating: $output.isLoadingMore, style: .large)
                                Spacer()
                            }
                            .listRowSeparator(.hidden)
                        }
                    }
                    .pullToRefresh(isShowing: $output.isReloading) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            output.isReloading = false
                        }
                        output.items = []
                        self.reloadIncome.send(InvoiceInput(from: output.dateFilter.optionalFrom, to: output.dateFilter.optionalTo, type: output.type.rawValue))
                    }
                    .listStyle(.plain)

                }
            }
        }
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            if output.isFirstLoad || output.dateFilter.isFiltered {
                output.isFirstLoad = false
                output.dateFilter.isFiltered = false
                output.items = []
                loadIncome.send(InvoiceInput(from: output.dateFilter.optionalFrom, to: output.dateFilter.optionalTo, type: output.type.rawValue))
            }
        }
        
    }
    
    init(viewModel: PurchaseHistoryViewModel) {
        let input = PurchaseHistoryViewModel.Input(
            loadPurchaseHistoryIncome: loadIncome.asDriver(), 
            reloadPurchaseHistoryIncome: reloadIncome.asDriver(),
            loadMorePurchaseHistoryIncome: loadMoreIncome.asDriver(),
            showFilterViewTrigger: showFilterViewTrigger.asDriver(), 
            showDetailViewTrigger: showDetailViewTrigger.asDriver(),
            popViewControllerTrigger: popViewControllerTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

extension UISegmentedControl {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
