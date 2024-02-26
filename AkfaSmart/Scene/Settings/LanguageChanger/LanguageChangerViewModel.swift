//
//  LanguageChangerView.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 16/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation

struct LanguageChangerViewModel {
    
}

extension LanguageChangerViewModel: ViewModel {
    struct Input {
        
    }
    
    final class Output: ObservableObject {
        @Published var items = [
            LanguageItemViewModel(title: "Русский"),
            LanguageItemViewModel(title: "O’zbekcha"),
            LanguageItemViewModel(title: "English")
        ]
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        return output
    }
}
