//
//  PurchaseHistoryViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
enum PurchaseHistoryType: String {
    case income = "RASXOD_KLIENT"
    case returnType = "VOZVRAT_KLIENT"
}

struct PurchaseHistoryViewModel {
    let navigator: PurchaseHistoryViewNavigatorType
    let useCase: PurchaseHistoryViewUseCaseType
}

extension PurchaseHistoryViewModel: ViewModel {
    struct Input {
        let loadPurchaseHistoryIncome: Driver<InvoiceInput>
        let reloadPurchaseHistoryIncome: Driver<InvoiceInput>
        let loadMorePurchaseHistoryIncome: Driver<InvoiceInput>
        let showFilterViewTrigger: Driver<Void>
        let showDetailViewTrigger: Driver<Invoice>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var alert = AlertMessage()
        @Published var items = [Invoice]()
        @Published var type: PurchaseHistoryType = .income
        @Published var hasMorePages = false
        @Published var dateFilter = DateFilter()
        @Published var isFirstLoad = true
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        let getIncomePageInfo = GetPageInput(loadTrigger: input.loadPurchaseHistoryIncome, reloadTrigger: input.reloadPurchaseHistoryIncome, loadMoreTrigger: input.loadMorePurchaseHistoryIncome, getItems: useCase.getInvoiceList)
        
        let (page,error,isLoading,isReloading,isLoadingMore) = getPage(input: getIncomePageInfo).destructured
        
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
                if let error = $0 as? APIUnknownError, error.error == "Not Found".localizedString {
                    return AlertMessage()
                }else {
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
        
        input.showFilterViewTrigger.sink {
            navigator.showDateFilterView(output.dateFilter)
        }
        .store(in: cancelBag)
        
        input.showDetailViewTrigger.sink { model in
            navigator.showPurchaseDetailView(model)
        }
        .store(in: cancelBag)
        
        return output
    }
}
