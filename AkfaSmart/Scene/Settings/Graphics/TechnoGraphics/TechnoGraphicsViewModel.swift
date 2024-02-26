//
//  TechnoViewModel.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//


import Foundation
struct TechnoGraphicsViewModel {
    
}

extension TechnoGraphicsViewModel: ViewModel {
    struct Input {
        
    }
    
    final class Output: ObservableObject {
        @Published var items = [
            InfoItemViewModel(title: "Цех манзили", value: "Наманган шахри, Лола кўчаси", editedValue: "Наманган шахри, Лола кўчаси"),
            InfoItemViewModel(title: "Цех майдони", value: "100 кв.м.", editedValue: "100 кв.м.")
        ]
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        return output
    }
}
