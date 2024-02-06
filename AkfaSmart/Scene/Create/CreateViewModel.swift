//
//  CreateViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 06/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct CreateOrderViewModel {
    let navigator: CreateOrderNavigatorType
    let useCase: CreateOrderUseCaseType
}

extension CreateOrderViewModel: ViewModel {
    struct Input {
        
    }
    
    final class Output: ObservableObject {
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        return output
    }
}
