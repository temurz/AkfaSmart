//
//  MyOrdersViewModel.swift
//  AkfaSmart
//

import Foundation
struct MyOrdersViewModel {
    let navigator: MyOrdersViewNavigatorType
    let useCase: MyOrdersViewUseCaseType
}

extension MyOrdersViewModel: ViewModel {
    struct Input {
        let loadOrdersTrigger: Driver<String>
        let reloadOrdersTrigger: Driver<String>
        let loadMoreOrdersTrigger: Driver<String>
        let popViewControllerTrigger: Driver<Void>
        let selectOrderTrigger: Driver<OrderSummary>
    }

    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var alert = AlertMessage()
        @Published var items = [OrderSummary]()
        @Published var hasMorePages = false
    }

    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()

        let getPageInfo = GetPageInput(loadTrigger: input.loadOrdersTrigger, reloadTrigger: input.reloadOrdersTrigger, loadMoreTrigger: input.loadMoreOrdersTrigger, getItems: useCase.getAllOrdersList)

        let (page, error, isLoading, isReloading, isLoadingMore) = getPage(input: getPageInfo).destructured

        page
            .handleEvents(receiveOutput: { pagingInfo in
                output.hasMorePages = pagingInfo.hasMorePages
            })
            .map { $0.items }
            .assign(to: \.items, on: output)
            .store(in: cancelBag)

        error
            .receive(on: RunLoop.main)
            .map {
                if let error = $0 as? APIUnknownError, error.error == "Not Found".localizedString {
                    output.hasMorePages = false
                    return AlertMessage()
                } else {
                    return AlertMessage(error: $0)
                }
            }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)

        isLoading
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)

        isReloading
            .assign(to: \.isReloading, on: output)
            .store(in: cancelBag)

        isLoadingMore
            .assign(to: \.isLoadingMore, on: output)
            .store(in: cancelBag)

        input.popViewControllerTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)

        input.selectOrderTrigger
            .sink { model in
                navigator.showOrderDetailView(model)
            }
            .store(in: cancelBag)

        return output
    }
}
