//
//  PaymentHistoryViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
enum PaymentHistoryType: String {
    case payment = "PAYMENT"
    case receipt = "RECEIPT"
}

struct PaymentHistoryViewModel {
    let useCase: PaymentHistoryViewUseCaseType
    let navigator: PaymentHistoryViewNavigatorType
}

extension PaymentHistoryViewModel: ViewModel {
    struct Input {
        let loadPaymentsHistoryIncome: Driver<ReceiptsInput>
        let reloadPaymentsHistoryIncome: Driver<ReceiptsInput>
        let loadMorePaymentsHistoryIncome: Driver<ReceiptsInput>
        let showFilterViewTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var alert = AlertMessage()
        @Published var items = [PaymentReceipt]()
        @Published var type: PaymentHistoryType = .payment
        @Published var hasMorePages = false
        @Published var dateFilter = DateFilter()
        @Published var isFirstLoad = true
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        let getPageInput = GetPageInput(loadTrigger: input.loadPaymentsHistoryIncome, reloadTrigger: input.reloadPaymentsHistoryIncome, loadMoreTrigger: input.loadMorePaymentsHistoryIncome, getItems: useCase.getPaymentReceiptList)
        
        let (page,error,isLoading,isReloading,isLoadingMore) = getPage(input: getPageInput).destructured
        
        page
            .handleEvents(receiveOutput:{
                pagingInfo in
                output.hasMorePages = pagingInfo.hasMorePages
            })
            .map { $0.items.map{ $0 } }
            .assign(to: \.items, on: output)
            .store(in: cancelBag)
        
        error
            .receive(on: RunLoop.main)
            .map {
                if !output.isFirstLoad {
                    AlertMessage(error: $0)
                }else {
                    AlertMessage(title: "", message: "", isShowing: false)
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
        
        input.showFilterViewTrigger
            .sink {
                navigator.showDateFilterView(output.dateFilter)
            }
            .store(in: cancelBag)
        
        return output
    }
}
