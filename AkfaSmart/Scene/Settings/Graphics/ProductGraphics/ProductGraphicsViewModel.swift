//
//  SecretgraphicsViewModel.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct ProductGraphicsViewModel {
    
}

extension ProductGraphicsViewModel: ViewModel {
    struct Input {
        
    }
    
    final class Output: ObservableObject {
        @Published var items = [
            MarketingItemViewModel(title: "Мехнат стажи", value: "10 йил"),
            MarketingItemViewModel(title: "Характери", value: "Харакатчан, бошқалар билан тез чиқишиб кета олади, ўз устида ишлайди")
        ]
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        return output
    }
}
