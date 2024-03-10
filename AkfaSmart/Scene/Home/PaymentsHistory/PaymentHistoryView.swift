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
    
    private let cancelBag = CancelBag()
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                Picker("", selection: $selection) {
                    Text("Income")
                        .font(.headline)
                        .padding()
                        .tag(0)
                    Text("Outcome")
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
                List {
                    ForEach(output.items, id: \.uniqueId) { item in
                        PaymentHistoryViewRow(model: item, type: output.type)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.blue)
                            .onAppear {
                                if output.items.last?.uniqueId == item.uniqueId && output.hasMorePages {
                                    output.isLoadingMore = true
                                    loadMoreHistoryTrigger.send(ReceiptsInput(from: output.dateFilter.optionalFrom, to: output.dateFilter.optionalTo, type: output.type.rawValue))
                                }
                            }
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
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
        .navigationTitle("Payment history")
        .navigationBarItems(trailing:
                                Button(action: {
            showFilterViewTrigger.send(())
        }, label: {
            Image("filter_icon")
                .resizable()
                .foregroundColor(Color.red)
        })
        )
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
            showFilterViewTrigger: showFilterViewTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}