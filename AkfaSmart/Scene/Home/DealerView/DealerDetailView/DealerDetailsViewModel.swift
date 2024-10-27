//
//  DealerDetailsViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 27/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct DealerDetailsViewModel {
    let navigator: DealerDetailsViewNavigatorType
}

extension DealerDetailsViewModel: ViewModel {
    
    struct Input {
        let dismissTrigger: Driver<Void>
        let openPurchasesTrigger: Driver<Void>
        let openPaymentsTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.dismissTrigger
            .sink {
                navigator.dismissViewController()
            }
            .store(in: cancelBag)
        
        input.openPurchasesTrigger
            .sink {
                navigator.showPurchasesHistoryView()
            }
            .store(in: cancelBag)
        
        input.openPaymentsTrigger
            .sink {
                navigator.showPaymentsHistoryView()
            }
            .store(in: cancelBag)
        return output
    }
}
