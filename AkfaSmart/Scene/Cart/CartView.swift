//
//  CartView.swift
//  AkfaSmart
//

import SwiftUI
import Combine
struct CartView: View {
    @ObservedObject var output: CartViewModel.Output

    private let loadCartTrigger = PassthroughSubject<Void, Never>()
    private let backTrigger = PassthroughSubject<Void, Never>()
    private let getDealersTrigger = PassthroughSubject<Void, Never>()
    private let selectDealerTrigger = PassthroughSubject<Void, Never>()
    private let chooseDealerTrigger = PassthroughSubject<Dealer, Never>()
    private let dismissDealerPickerTrigger = PassthroughSubject<Void, Never>()
    private let incrementTrigger = PassthroughSubject<Int, Never>()
    private let decrementTrigger = PassthroughSubject<Int, Never>()
    private let removeTrigger = PassthroughSubject<Int, Never>()
    private let submitOrderTrigger = PassthroughSubject<Void, Never>()
    private let dismissSuccessTrigger = PassthroughSubject<Void, Never>()

    private let cancelBag = CancelBag()

    var body: some View {
        ZStack {
            LoadingView(isShowing: $output.isLoading, text: .constant("")) {
                VStack(spacing: 0) {
                    CustomNavigationBar(title: "ORDER_INFO_TITLE".localizedString) {
                        backTrigger.send(())
                    }

                    if output.items.isEmpty {
                        VStack {
                            Spacer()
                            Text("LIST_IS_EMPTY".localizedString)
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                    } else {
                        List {
                            ForEach(output.items) { item in
                                CartItemRow(
                                    item: item,
                                    onIncrement: { incrementTrigger.send(item.id) },
                                    onDecrement: { decrementTrigger.send(item.id) },
                                    onRemove: { removeTrigger.send(item.id) }
                                )
                                .listRowSeparator(.hidden)
                            }
                        }
                        .listStyle(.plain)
                    }

                    Button {
                        selectDealerTrigger.send(())
                    } label: {
                        HStack {
                            if let dealer = output.selectedDealer {
                                VStack(alignment: .leading) {
                                    Text(dealer.name ?? "")
                                        .foregroundColor(Colors.primaryTextColor)
                                    Text((dealer.balance?.convertDecimals() ?? "") + "SUM_UZS".localizedString)
                                        .font(.subheadline)
                                        .foregroundColor(dealer.balance ?? 0 >= 0 ? .green : .red)
                                }
                            } else {
                                Text("SELECT_DEALER".localizedString)
                                    .foregroundColor(Colors.primaryTextColor)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Colors.secondaryTextColor)
                        }
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Colors.oldBorderColor)
                        }
                        .padding(.horizontal)
                    }

                    HStack {
                        VStack(alignment: .leading) {
                            Text(output.totalPrice.convertDecimals() + "UZS".localizedString)
                                .font(.headline)
                            Text("\(output.totalQuantity) " + "ITEMS_SUFFIX".localizedString)
                                .font(.footnote)
                                .foregroundColor(Colors.secondaryTextColor)
                        }
                        Spacer()
                        Button {
                            submitOrderTrigger.send(())
                        } label: {
                            Text("SUBMIT_ORDER".localizedString)
                                .foregroundColor(.white)
                                .padding(.horizontal, 24)
                                .frame(height: 50)
                                .background(output.selectedDealer == nil || output.items.isEmpty ? Colors.blockedGrayTextColor : Colors.customRedColor)
                                .cornerRadius(8)
                        }
                        .disabled(output.selectedDealer == nil || output.items.isEmpty)
                    }
                    .padding()
                }
            }

            if output.isDealerPickerPresented {
                DealerPickerSheetView(
                    dealers: output.dealers,
                    selected: output.selectedDealer,
                    onSelect: { dealer in chooseDealerTrigger.send(dealer) },
                    onDismiss: { dismissDealerPickerTrigger.send(()) }
                )
            }

            if output.submittedOrderId != nil {
                OrderSuccessDialogView(
                    orderId: output.submittedOrderId,
                    onDismiss: { dismissSuccessTrigger.send(()) }
                )
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            loadCartTrigger.send(())
            getDealersTrigger.send(())
        }
        .alert(isPresented: $output.alert.isShowing) {
            Alert(title: Text(output.alert.title), message: Text(output.alert.message), dismissButton: .default(Text("OK")))
        }
    }

    init(viewModel: CartViewModel) {
        let input = CartViewModel.Input(
            loadCartTrigger: loadCartTrigger.asDriver(),
            backTrigger: backTrigger.asDriver(),
            getDealersTrigger: getDealersTrigger.asDriver(),
            selectDealerTrigger: selectDealerTrigger.asDriver(),
            chooseDealerTrigger: chooseDealerTrigger.asDriver(),
            dismissDealerPickerTrigger: dismissDealerPickerTrigger.asDriver(),
            incrementTrigger: incrementTrigger.asDriver(),
            decrementTrigger: decrementTrigger.asDriver(),
            removeTrigger: removeTrigger.asDriver(),
            submitOrderTrigger: submitOrderTrigger.asDriver(),
            dismissSuccessTrigger: dismissSuccessTrigger.asDriver()
        )
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
