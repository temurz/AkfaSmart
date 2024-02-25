//
//  HomeViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct HomeViewModel {
    let navigator: HomeViewNavigatorType
    let useCase: HomeViewUseCaseType
}

extension HomeViewModel: ViewModel {
    struct Input {
        let openPurchasesTrigger: Driver<Int>
        let openPaymentsTrigger: Driver<Int>
        let calculateTotalAmounts: Driver<Void>
        let getDealersTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var visible: Bool = AuthApp.shared.visibility
        @Published var totalOfMonth = 0.0
        @Published var totalOfYear = 0.0
        @Published var isLoading = false
        @Published var hasDealers = false
        @Published var items: [Dealer] = []
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.calculateTotalAmounts.sink {
            output.totalOfMonth = output.items
                .map { $0.purchaseForMonth }
                .reduce(0,+)
            
            output.totalOfYear = output.items
                .map {$0.purchaseForYear}
                .reduce(0, +)
        }
        .store(in: cancelBag)
        
        input.getDealersTrigger
            .map { _ in
                useCase.checkHasADealer()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { bool in
                if bool {
                    useCase.getDealers()
                        .trackError(errorTracker)
                        .trackActivity(activityTracker)
                        .asDriver()
                        .map { dealers in
                            output.totalOfMonth = dealers
                                .map { $0.purchaseForMonth }
                                .reduce(0,+)
                            
                            output.totalOfYear = dealers
                                .map {$0.purchaseForYear}
                                .reduce(0, +)
                            
                            output.hasDealers = bool
                            output.items = dealers
                        }
                        .sink()
                        .store(in: cancelBag)
                }else {
                    output.items = []
                }
            }
            )
            .store(in: cancelBag)
        
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
