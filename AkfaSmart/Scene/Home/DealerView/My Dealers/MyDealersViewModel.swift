//
//  MyDealersViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 01/12/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct MyDealersViewModel {
    let navigator: MyDealersViewNavigatorType
    let useCase: MyDealersViewUseCaseType
    let dealers: [Dealer]
}

extension MyDealersViewModel: ViewModel {
    struct Input {
        let getDealersTrigger: Driver<Void>
        let showDealerDetailTrigger: Driver<Dealer>
        let addDealerTrigger: Driver<Void>
        let backTrigger: Driver<Void>
    }
    
    class Output: ObservableObject {
        var dealers: [Dealer]
        var isLoading = false
        var alert = AlertMessage()
        
        init(dealers: [Dealer]) {
            self.dealers = dealers
        }
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output(dealers: self.dealers)
        
        input.getDealersTrigger.sink {
            if output.dealers.isEmpty {
                useCase.getDealers()
                    .map { dealers in
                        output.dealers = dealers
                    }
                    .sink()
                    .store(in: cancelBag)
            }
        }
        .store(in: cancelBag)
        
        input.backTrigger.sink {
            navigator.popView()
        }
        .store(in: cancelBag)
        
        input.showDealerDetailTrigger
            .sink { dealer in
                navigator.showDealersDetailViewModally(dealer: dealer)
            }
            .store(in: cancelBag)
        
        input.addDealerTrigger
            .sink {
                
            }
            .store(in: cancelBag)
        
        return output
    }
}
