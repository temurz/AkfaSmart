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
    }
    
    final class Output: ObservableObject {
        @Published var visible: Bool = AuthApp.shared.visibility
        @Published var totalOfMonth = 0.0
        @Published var totalOfYear = 0.0
        @Published var items = [
            Dealer(dealerId: 0, dealerClientCid: 0, name: nil, clientName: nil, balance: 0, purchaseForMonth: 0, purchaseForYear: 0),
            Dealer(dealerId: 1, dealerClientCid: 0, name: nil, clientName: nil, balance: 0, purchaseForMonth: 0, purchaseForYear: 0),
            Dealer(dealerId: 2, dealerClientCid: 0, name: nil, clientName: nil, balance: 0, purchaseForMonth: 20, purchaseForYear: 0),
            Dealer(dealerId: 3, dealerClientCid: 0, name: nil, clientName: nil, balance: 0, purchaseForMonth: 100, purchaseForYear: 0)
        ]
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
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
        
        return output
    }
}
