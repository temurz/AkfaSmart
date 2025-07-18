//
//  PaymentHistoryView.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import SwiftUIRefresh
struct PaymentHistoryView: View {
    @ObservedObject var output: PaymentHistoryViewModel.Output
    @State var selection = 0
    private let loadHistoryTrigger = PassthroughSubject<ReceiptsInput,Never>()
    private let reloadHistoryTrigger = PassthroughSubject<ReceiptsInput,Never>()
    private let loadMoreHistoryTrigger = PassthroughSubject<ReceiptsInput,Never>()
    private let showFilterViewTrigger = PassthroughSubject<Void,Never>()
    
    private let popViewControllerTrigger = PassthroughSubject<Void, Never>()
    
    private let cancelBag = CancelBag()
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "PAYMENT_HISTORY_TITLE".localizedString, rightBarImage: "filter_icon") {
                    popViewControllerTrigger.send(())
                } onRightBarButtonTapAction: {
                    showFilterViewTrigger.send(())
                }
                Picker("", selection: $selection) {
                    Text("OUTCOME_PAYMENT".localizedString)
                        .font(.headline)
                        .padding()
                        .tag(0)
                    Text("INCOME_PAYMENT".localizedString)
                        .font(.headline)
                        .padding()
                        .tag(1)
                }
                .pickerStyle(.segmented)
                .frame(height: 32)
                .padding()
                .onChange(of: selection) { tag in
                    output.type = tag == 0 ? .payment : .receipt
                    output.items = []
                    loadHistoryTrigger.send(ReceiptsInput(
                        from: output.dateFilter.optionalFrom,
                        to: output.dateFilter.optionalTo,
                        type: output.type.rawValue))
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
                        ForEach(output.items, id: \.uniqueId) { item in
                            PaymentHistoryViewRow(model: item, type: output.type)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onAppear {
                                    if output.items.last?.uniqueId == item.uniqueId && output.hasMorePages {
                                        output.isLoadingMore = true
                                        loadMoreHistoryTrigger.send(ReceiptsInput(from: output.dateFilter.optionalFrom, to: output.dateFilter.optionalTo, type: output.type.rawValue))
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
                    .listStyle(PlainListStyle())
                    .pullToRefresh(isShowing: $output.isReloading) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            output.isReloading = false
                        }
                        output.items = []
                        self.reloadHistoryTrigger.send(ReceiptsInput(
                            from: output.dateFilter.optionalFrom,
                            to: output.dateFilter.optionalTo,
                            type: output.type.rawValue))
                    }
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
                loadHistoryTrigger.send(ReceiptsInput(from: output.dateFilter.optionalFrom, to: output.dateFilter.optionalTo, type: output.type.rawValue))
            }
        }
    }
    
    init(viewModel: PaymentHistoryViewModel) {
        let input = PaymentHistoryViewModel.Input(
            loadPaymentsHistoryIncome: loadHistoryTrigger.asDriver(),
            reloadPaymentsHistoryIncome: reloadHistoryTrigger.asDriver(),
            loadMorePaymentsHistoryIncome: loadMoreHistoryTrigger.asDriver(),
            showFilterViewTrigger: showFilterViewTrigger.asDriver(),
            popViewController: popViewControllerTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
