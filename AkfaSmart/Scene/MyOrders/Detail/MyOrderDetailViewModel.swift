//
//  MyOrderDetailViewModel.swift
//  AkfaSmart
//

import Foundation
struct MyOrderDetailViewModel {
    let model: OrderSummary
    let useCase: MyOrderDetailViewUseCaseType
    let navigator: PopViewNavigatorType
}

extension MyOrderDetailViewModel: ViewModel {
    struct Input {
        let loadItemsTrigger: Driver<Void>
        let cancelOrderTrigger: Driver<Void>
        let popViewControllerTrigger: Driver<Void>
    }

    final class Output: ObservableObject {
        @Published var items = [CartItem]()
        @Published var isLoading = false
        @Published var alert = AlertMessage()
    }

    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()

        input.loadItemsTrigger
            .sink {
                useCase.getOrderItems(orderId: model.id)
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            output.alert = AlertMessage(error: error)
                        }
                    }, receiveValue: { items in
                        output.items = items
                    })
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)

        input.cancelOrderTrigger
            .sink {
                output.isLoading = true
                useCase.cancelOrder(orderId: model.id)
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { completion in
                        output.isLoading = false
                        if case .failure(let error) = completion {
                            output.alert = AlertMessage(error: error)
                        }
                    }, receiveValue: { success in
                        if success {
                            navigator.popView()
                        }
                    })
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)

        input.popViewControllerTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)

        return output
    }
}
