//
//  CartViewModel.swift
//  AkfaSmart
//

import Foundation
import UIKit
struct CartViewModel {
    let useCase: CartViewUseCaseType
    let navigationController: UINavigationController
}

extension CartViewModel: ViewModel {
    struct Input {
        let loadCartTrigger: Driver<Void>
        let backTrigger: Driver<Void>
        let getDealersTrigger: Driver<Void>
        let selectDealerTrigger: Driver<Void>
        let chooseDealerTrigger: Driver<Dealer>
        let dismissDealerPickerTrigger: Driver<Void>
        let incrementTrigger: Driver<Int>
        let decrementTrigger: Driver<Int>
        let removeTrigger: Driver<Int>
        let submitOrderTrigger: Driver<Void>
        let dismissSuccessTrigger: Driver<Void>
    }

    final class Output: ObservableObject {
        @Published var items = [CartItem]()
        @Published var dealers = [Dealer]()
        @Published var selectedDealer: Dealer?
        @Published var isDealerPickerPresented = false
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var totalPrice: Double = 0
        @Published var totalQuantity: Int = 0
        @Published var orderId: Int?
        @Published var submittedOrderId: Int?
    }

    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()

        func reloadCart() {
            useCase.getCartItems()
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        if let apiError = error as? APIUnknownError, apiError.error == "Cart not found" {
                            output.items = []
                            output.totalPrice = 0
                            output.totalQuantity = 0
                        } else {
                            output.alert = AlertMessage(error: error)
                        }
                    }
                }, receiveValue: { summary in
                    output.items = summary.items
                    output.totalPrice = summary.totalPrice
                    output.totalQuantity = Int(summary.totalQuantity)
                    output.orderId = summary.id
                })
                .store(in: cancelBag)
            CartManager.shared.refreshCount()
        }

        input.loadCartTrigger
            .sink { reloadCart() }
            .store(in: cancelBag)

        input.backTrigger
            .sink {
                navigationController.popViewController(animated: true)
            }
            .store(in: cancelBag)

        input.getDealersTrigger
            .sink {
                useCase.getDealers()
                    .receive(on: RunLoop.main)
                    .map { output.dealers = $0 }
                    .sink()
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)

        input.selectDealerTrigger
            .sink {
                output.isDealerPickerPresented = true
            }
            .store(in: cancelBag)

        input.dismissDealerPickerTrigger
            .sink {
                output.isDealerPickerPresented = false
            }
            .store(in: cancelBag)

        input.chooseDealerTrigger
            .sink { dealer in
                guard let dealerId = dealer.dealerId else { return }
                output.isDealerPickerPresented = false
                useCase.addDealerToOrder(dealerId: dealerId)
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            output.alert = AlertMessage(error: error)
                        }
                    }, receiveValue: { _ in
                        output.selectedDealer = dealer
                    })
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)

        input.incrementTrigger
            .sink { orderItemId in
                guard let item = output.items.first(where: { $0.id == orderItemId }) else { return }
                useCase.changeOrderItemQuantity(orderItemId: orderItemId, quantity: item.quantityInt + 1)
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            output.alert = AlertMessage(error: error)
                        }
                    }, receiveValue: { _ in reloadCart() })
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)

        input.decrementTrigger
            .sink { orderItemId in
                guard let item = output.items.first(where: { $0.id == orderItemId }) else { return }
                let newQuantity = item.quantityInt - 1
                let request = newQuantity <= 0
                    ? useCase.deleteOrderItem(orderItemId: orderItemId)
                    : useCase.changeOrderItemQuantity(orderItemId: orderItemId, quantity: newQuantity)
                request
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            output.alert = AlertMessage(error: error)
                        }
                    }, receiveValue: { _ in reloadCart() })
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)

        input.removeTrigger
            .sink { orderItemId in
                useCase.deleteOrderItem(orderItemId: orderItemId)
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            output.alert = AlertMessage(error: error)
                        }
                    }, receiveValue: { _ in reloadCart() })
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)

        input.submitOrderTrigger
            .sink {
                guard output.selectedDealer != nil, !output.items.isEmpty else { return }
                let completedOrderId = output.orderId
                output.isLoading = true
                useCase.completeOrder()
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { completion in
                        output.isLoading = false
                        if case .failure(let error) = completion {
                            output.alert = AlertMessage(error: error)
                        }
                    }, receiveValue: { success in
                        if success {
                            CartManager.shared.refreshCount()
                            output.submittedOrderId = completedOrderId
                        }
                    })
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)

        input.dismissSuccessTrigger
            .sink {
                output.submittedOrderId = nil
                navigationController.popViewController(animated: true)
            }
            .store(in: cancelBag)

        return output
    }
}
