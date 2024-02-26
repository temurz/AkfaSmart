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
        let selectRowTrigger: Driver<Int>
        let deleteAccountTrigger: Driver<Void>
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
        
        input.deleteAccountTrigger.sink { _ in
            AuthApp.shared.token = nil
            AuthApp.shared.username = nil
            navigator.showLogin()
        }
        .store(in: cancelBag)
        
        input.selectRowTrigger.sink { id in
            switch id {
            case 1:
                navigator.showInfographics()
            case 2:
                navigator.showTechnographics()
            case 3:
                navigator.showHRgraphics()
            case 4:
                navigator.showMarketinggraphics()
            case 5:
                navigator.showProductGraphics()
            case 6:
                break
            case 7:
                break
            case 8:
                navigator.showLanguageChanger()
            default:
                break
            }
            
        }
        .store(in: cancelBag)
        
        return output
    }
}
