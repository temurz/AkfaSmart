//
//  SettingsViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct SettingItemViewModel: Identifiable {
    let id: Int
    let image: String
    let text: String
    let isToggle: Bool = false
}
struct SettingsViewModel {
    let navigator: SettingsNavigatorType
    let useCase: SettingsUseCaseType
}

extension SettingsViewModel: ViewModel {
    struct Input {
        
    }
    
    final class Output: ObservableObject {
        @Published var items = [[
            SettingItemViewModel(id: 0, image: "person", text: "Personal data"),
            SettingItemViewModel(id: 1, image: "", text: "Infographics"),
            SettingItemViewModel(id: 2, image: "", text: "Technographics"),
            SettingItemViewModel(id: 3, image: "", text: "HR graphics"),
            SettingItemViewModel(id: 4, image: "", text: "Market graphics"),
            SettingItemViewModel(id: 5, image: "", text: "Secret graphics"),
            ],
            [            
                SettingItemViewModel(id: 6, image: "headset_mic", text: "Technical support"),
                SettingItemViewModel(id: 7, image: "lock", text: "PIN-code"),
                SettingItemViewModel(id: 8, image: "translate", text: "Language")
            ]
        ]
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        return output
    }
}
