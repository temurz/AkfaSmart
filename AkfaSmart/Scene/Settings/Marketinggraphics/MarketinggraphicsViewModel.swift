//
//  MarketinggraphicsViewModel.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//


import Foundation
struct MarketinggraphicsViewModel {
    
}

extension MarketinggraphicsViewModel: ViewModel {
    struct Input {
        
    }
    
    final class Output: ObservableObject {
        @Published var items = [
            MarketingItemViewModel(title: "Офис ёки шоурумнинг мавжудлиги", value: "Офис мавжуд/шоурум йўқ"),
            MarketingItemViewModel(title: "Рекламадан фойдаланадими", value: "Ижтимоий тармоқларда реклама бериб туради, Инстаграмда канали бор")
        ]
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        return output
    }
}
