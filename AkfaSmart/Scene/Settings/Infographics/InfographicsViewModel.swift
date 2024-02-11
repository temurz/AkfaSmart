//
//  View.swift
//  AkfaSmart
//
//  Created by Temur on 11/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct InfographicsViewModel {
    
}

extension InfographicsViewModel: ViewModel {
    struct Input {
        
    }
    
    final class Output: ObservableObject {
        @Published var items = [
            InfoItemViewModel(title: "ФИО", value: "Jack Smith"),
            InfoItemViewModel(title: "Дата рождения", value: "21.02.1995")
        ]
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        return output
    }
}
