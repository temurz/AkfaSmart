//
//  LanguageChangerView.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 16/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation

struct LanguageChangerViewModel {
    let navigator: LanguageViewNavigatorType
}

extension LanguageChangerViewModel: ViewModel {
    struct Input {
        let saveTrigger: Driver<Void>
        let getCurrentLanguageTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var items = [LanguageItemViewModel]()
        @Published var selectedRow: LanguageItemViewModel? = nil
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.getCurrentLanguageTrigger
            .sink {
                let lang = AuthApp.shared.language
                var id = 2
                switch lang {
                case "ru":
                    output.selectedRow = LanguageItemViewModel(id: 0, title: "Русский")
                case "uz":
                    output.selectedRow = LanguageItemViewModel(id: 1, title: "O’zbekcha")
                default:
                    output.selectedRow = LanguageItemViewModel(id: 2, title: "English")
                }
                
                output.items = [
                    LanguageItemViewModel(id: 0,title: "Русский"),
                    LanguageItemViewModel(id: 1, title: "O’zbekcha"),
                    LanguageItemViewModel(id: 2, title: "English")
                ]
            }
            .store(in: cancelBag)
        
        input.saveTrigger
            .sink {
                switch output.selectedRow?.id {
                case 0:
                    AuthApp.shared.language = "ru"
                case 1:
                    AuthApp.shared.language = "uz"
                case 2:
                    AuthApp.shared.language = "en"
                default:
                    AuthApp.shared.language = "en"
                }
                navigator.popViewController()
            }
            .store(in: cancelBag)
        
        return output
    }
}
