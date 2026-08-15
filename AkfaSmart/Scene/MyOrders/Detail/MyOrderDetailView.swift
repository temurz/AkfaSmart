//
//  MyOrderDetailView.swift
//  AkfaSmart
//

import SwiftUI
import Combine
struct MyOrderDetailView: View {
    let model: OrderSummary
    @ObservedObject var output: MyOrderDetailViewModel.Output

    private let loadItemsTrigger = PassthroughSubject<Void, Never>()
    private let cancelOrderTrigger = PassthroughSubject<Void, Never>()
    private let popViewControllerTrigger = PassthroughSubject<Void, Never>()

    private let cancelBag = CancelBag()

    private var status: OrderListStatus? {
        OrderListStatus(rawValue: model.orderStatus ?? "")
    }

    var body: some View {
        LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack(spacing: 0) {
                CustomNavigationBar(title: "ORDER_DETAIL_TITLE".localizedString) {
                    popViewControllerTrigger.send(())
                }

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("ORDER_WITH_NUMBER".localizedString)
                            .foregroundColor(Colors.secondaryTextColor)
                        Spacer()
                        Text("\(model.id)")
                            .foregroundColor(Colors.primaryTextColor)
                    }
                    HStack {
                        Text("DEALER".localizedString)
                            .foregroundColor(Colors.secondaryTextColor)
                        Spacer()
                        Text(model.dealerName ?? "")
                            .foregroundColor(Colors.primaryTextColor)
                    }
                    HStack {
                        Text("QUANTITY_WITH_COLON".localizedString)
                            .foregroundColor(Colors.secondaryTextColor)
                        Spacer()
                        Text("\(Int(model.totalQuantity ?? 0))")
                            .foregroundColor(Colors.primaryTextColor)
                    }
                    HStack {
                        Text("TOTAL_AMOUNT".localizedString)
                            .foregroundColor(Colors.secondaryTextColor)
                        Spacer()
                        Text((model.totalPrice?.convertDecimals() ?? "0") + "UZS".localizedString)
                            .bold()
                            .foregroundColor(Colors.primaryTextColor)
                    }
                }
                .padding()

                List {
                    ForEach(output.items) { item in
                        MyOrderDetailItemRow(item: item)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)

                if status == .new {
                    Button {
                        cancelOrderTrigger.send(())
                    } label: {
                        Text("CANCEL_ORDER".localizedString)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Colors.customRedColor)
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            loadItemsTrigger.send(())
        }
    }

    init(model: OrderSummary, viewModel: MyOrderDetailViewModel) {
        self.model = model
        let input = MyOrderDetailViewModel.Input(
            loadItemsTrigger: loadItemsTrigger.asDriver(),
            cancelOrderTrigger: cancelOrderTrigger.asDriver(),
            popViewControllerTrigger: popViewControllerTrigger.asDriver()
        )
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
