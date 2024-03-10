//
//  TechnicalSupportViewModel.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 10/03/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation

struct TechnicalSupportViewModel:Identifiable {
    let id = UUID()
    let sender: String
    let text: String
    let isSender: Bool
    
}

extension TechnicalSupportViewModel: ViewModel {
    struct Input {
        
    }
    
    final class Output: ObservableObject {
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        return output
    }
}
