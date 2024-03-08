//
//  PurchaseDetailViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct PurchaseDetailViewModel {
    let useCase: PurchaseDetailViewUseCaseType
}

extension PurchaseDetailViewModel: ViewModel {
    struct Input {
        let loadDetailsTrigger: Driver<InvoiceDetailViewInput>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var items: [InvoiceDetail] = []
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.loadDetailsTrigger
            .sink { input in
            useCase.getInvoiceDetail(invoiceId: input.invoiceId, dealerId: input.dealerId)
                .trackError(errorTracker)
                .trackActivity(activityTracker)
                .asDriver()
                .sink { detailItems in
                    output.items = detailItems
                }
                .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
}

struct InvoiceDetailViewInput {
    let invoiceId: Int
    let dealerId: Int
}
