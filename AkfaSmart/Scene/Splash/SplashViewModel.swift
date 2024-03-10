//
//  SplashViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct SplashViewModel {
    let navigator: SplashViewNavigatorType
}

extension SplashViewModel: ViewModel {
    struct Input {
        let loadViewsTrigger: Driver<Void>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        
        input.loadViewsTrigger.sink { _ in
            let hasToken = AuthApp.shared.token != nil
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                if hasToken {
                    navigator.showMain(page: .home)
                }else {
                    navigator.showLogin()
                }
            }
        }
        .store(in: cancelBag)
        
        return Output()
    }
}
