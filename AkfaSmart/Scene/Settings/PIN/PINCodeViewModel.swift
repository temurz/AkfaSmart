//
//  PINCodeViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 19/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
enum PINCodeState: String {
    case createNew = "CREATE_NEW_PIN_TITLE"
    case repeatPIN = "REPEAT_PIN_TITLE"
    case onAuth = "CREATE_NEW_PIN_ON_AUTH"
    case enterSimple = "ENTER_PIN_SIMPLE_TITLE"
    case oldPin = "OLD_PIN_TITLE"
    case removePIN = "REMOVE_PIN_TITLE"
}

struct PINCodeViewModel {
    let state: PINCodeState
    let navigator: PINCodeViewNavigatorType
}

extension PINCodeViewModel: ViewModel {
    struct Input {
        let saveCodeTrigger: Driver<Void>
        let skipTrigger: Driver<Void>
        let popViewControllerTrigger: Driver<Void>
        let checkHasParentControllerTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var code = ""
        @Published var firstLetterFilled = false
        @Published var secondLetterFilled = false
        @Published var thirdLetterFilled = false
        @Published var fourthLetterFilled = false
        @Published var validationMessage = ""
        @Published var state: PINCodeState
        @Published var toast: Toast? = nil
        @Published var hasParentController: Bool = false
        
        init(state: PINCodeState) {
            self.state = state
        }
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output(state: state)
        
        input.skipTrigger
            .sink {
                navigator.showMain(page: .home)
            }
            .store(in: cancelBag)
        
        input.saveCodeTrigger
            .sink {
                switch output.state {
                case .onAuth:
                    AuthApp.shared.appEnterCode = output.code
                    output.state = .repeatPIN
                    toInitialState()
                case .createNew:
                    AuthApp.shared.appEnterCode = output.code
                    output.state = .repeatPIN
                    toInitialState()
                    break
                case .repeatPIN:
                    if AuthApp.shared.appEnterCode == output.code {
                        AuthApp.shared.appEnterCode = output.code
                        output.toast = Toast(style: .success, message: "PIN_CODE_SAVED".localizedString)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            navigator.goToMainOrPop()
                        }
                    }else {
                        output.validationMessage = "WRONG_PIN_CODE".localizedString
                    }
                    break
                case .enterSimple:
                    if AuthApp.shared.appEnterCode == output.code {
                        navigator.showMain(page: .home)
                    }else {
                        output.validationMessage = "WRONG_PIN_CODE".localizedString
                    }
                    break
                case .oldPin:
                    if AuthApp.shared.appEnterCode == output.code {
                        output.state = .removePIN
                    }else {
                        output.validationMessage = "WRONG_PIN_CODE".localizedString
                    }
                    toInitialState()
                    break
                case .removePIN:
                    if AuthApp.shared.appEnterCode == output.code {
                        AuthApp.shared.appEnterCode = nil
                        output.toast = Toast(style: .success, message: "PIN_CODE_REMOVED".localizedString)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            navigator.popView()
                        }
                    }else {
                        output.validationMessage = "WRONG_PIN_CODE".localizedString
                    }
                    break
                }
            }
            .store(in: cancelBag)
        
        input.popViewControllerTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)
        
        input.checkHasParentControllerTrigger
            .sink {
                output.hasParentController =  navigator.checkHasParentController()
            }
            .store(in: cancelBag)
        
        func toInitialState() {
            output.code = ""
            output.firstLetterFilled = false
            output.secondLetterFilled = false
            output.thirdLetterFilled = false
            output.fourthLetterFilled = false
        }
        
        return output
    }
    
    
}
