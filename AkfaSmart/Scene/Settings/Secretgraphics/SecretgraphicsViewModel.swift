//
//  SecretgraphicsViewModel.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct SecretgraphicsViewModel {
    
}

extension SecretgraphicsViewModel: ViewModel {
    struct Input {
        
    }
    
    final class Output: ObservableObject {
        @Published var items = [
            SecretItemViewModel(title: "Мехнат стажи", value: "10 йил"),
            SecretItemViewModel(title: "Характери", value: "Харакатчан, бошқалар билан тез чиқишиб кета олади, ўз устида ишлайди")
        ]
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        return output
    }
}
