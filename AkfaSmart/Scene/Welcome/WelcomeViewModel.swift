//
//  WelcomeViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation

struct WelcomeViewModel {
    let navigator: WelcomeViewNavigatorType
}

extension WelcomeViewModel: ViewModel {
    struct Input {
        let showDealerViewTrigger: Driver<Void>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.showDealerViewTrigger.sink { _ in
            navigator.showAddDealerView()
        }
        .store(in: cancelBag)
        
        return output
    }
}
