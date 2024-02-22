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
        
    }
    
    final class Output: ObservableObject {
        @Published var visible: Bool = AuthApp.shared.visibility
        @Published var dealerPage = 0
        @Published var items = [
            Dealer(dealerId: 0, dealerClientCid: 0, name: nil, clientName: nil, balance: 0, purchaseForMonth: 0, purchaseForYear: 0),
            Dealer(dealerId: 1, dealerClientCid: 0, name: nil, clientName: nil, balance: 0, purchaseForMonth: 0, purchaseForYear: 0),
            Dealer(dealerId: 2, dealerClientCid: 0, name: nil, clientName: nil, balance: 0, purchaseForMonth: 0, purchaseForYear: 0),
            Dealer(dealerId: 3, dealerClientCid: 0, name: nil, clientName: nil, balance: 0, purchaseForMonth: 0, purchaseForYear: 0)
        ]
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        return output
    }
}
