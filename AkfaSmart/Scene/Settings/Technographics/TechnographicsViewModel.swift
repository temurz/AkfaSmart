//
//  TechnoViewModel.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//


import Foundation
struct TechnographicsViewModel {
    
}

extension TechnographicsViewModel: ViewModel {
    struct Input {
        
    }
    
    final class Output: ObservableObject {
        @Published var items = [
            TechnoItemViewModel(title: "Цех манзили", value: "Наманган шахри, Лола кўчаси"),
            TechnoItemViewModel(title: "Цех майдони", value: "100 кв.м.")
        ]
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        return output
    }
}
