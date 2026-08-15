//
//  MyOrdersView.swift
//  AkfaSmart
//

import SwiftUI
import Combine
struct MyOrdersView: View {
    @ObservedObject var output: MyOrdersViewModel.Output
    @State var selection: OrderListStatus = .new

    private let loadOrders = PassthroughSubject<String, Never>()
    private let reloadOrders = PassthroughSubject<String, Never>()
    private let loadMoreOrders = PassthroughSubject<String, Never>()
    private let popViewControllerTrigger = PassthroughSubject<Void, Never>()
    private let selectOrderTrigger = PassthroughSubject<OrderSummary, Never>()

    private let cancelBag = CancelBag()

    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "MY_ORDERS".localizedString) {
                    popViewControllerTrigger.send(())
                }

                Picker("", selection: $selection) {
                    ForEach(OrderListStatus.allCases, id: \.self) { status in
                        Text(status.title)
                            .font(.headline)
                            .tag(status)
                    }
                }
                .pickerStyle(.segmented)
                .frame(height: 32)
                .padding()
                .onChange(of: selection) { status in
                    output.items = []
                    loadOrders.send(status.rawValue)
                }

                if output.items.isEmpty && !output.isLoading {
                    VStack(alignment: .center) {
                        Spacer()
                        Text("LIST_IS_EMPTY".localizedString)
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(output.items) { item in
                            MyOrderRow(model: item)
                                .onTapGesture {
                                    selectOrderTrigger.send(item)
                                }
                                .onAppear {
                                    if output.items.last?.id == item.id && output.hasMorePages {
                                        output.isLoadingMore = true
                                        loadMoreOrders.send(selection.rawValue)
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
            loadOrders.send(selection.rawValue)
        }
    }

    init(viewModel: MyOrdersViewModel) {
        let input = MyOrdersViewModel.Input(
            loadOrdersTrigger: loadOrders.asDriver(),
            reloadOrdersTrigger: reloadOrders.asDriver(),
            loadMoreOrdersTrigger: loadMoreOrders.asDriver(),
            popViewControllerTrigger: popViewControllerTrigger.asDriver(),
            selectOrderTrigger: selectOrderTrigger.asDriver()
        )

        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
