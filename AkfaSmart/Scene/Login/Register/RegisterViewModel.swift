//
//  RegisterViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 27/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Combine
import SwiftUI
import ValidatedPropertyKit
import CombineExt

struct RegisterViewModel {
    let navigator: RegisterNavigatorType
    let useCase: RegisterUseCaseType
}

// MARK: - ViewModelType
extension RegisterViewModel: ViewModel {
    final class Input: ObservableObject {
        @Published var username = "998900109258"
        @Published var password = "123456"
        @Published var repeatedPassword = "123456"
        let registerTrigger: Driver<Void>
        let showLoginTrigger: Driver<Void>
        
        init(registerTrigger: Driver<Void>, showLoginTrigger: Driver<Void>) {
            self.registerTrigger = registerTrigger
            self.showLoginTrigger = showLoginTrigger
        }
    }
    
    final class Output: ObservableObject {
        @Published var isRegisterEnabled = true
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var usernameValidationMessage = ""
        @Published var passwordValidationMessage = ""
        @Published var repeatedPasswordValidationMessage = ""
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        let usernameValidation = Publishers
            .CombineLatest(input.$username, input.registerTrigger)
            .map { $0.0 }
            .map(RegisterDto.validateUserName(_:))
        
        usernameValidation
            .asDriver()
            .map { $0.message }
            .assign(to: \.usernameValidationMessage, on: output)
            .store(in: cancelBag)
        
        let passwordValidation = Publishers
            .CombineLatest(input.$password, input.registerTrigger)
            .map { $0.0 }
            .map(RegisterDto.validatePassword(_:))
            
        passwordValidation
            .asDriver()
            .map { $0.message }
            .assign(to: \.passwordValidationMessage, on: output)
            .store(in: cancelBag)
        
        let repeatedPasswordValidation = Publishers
            .CombineLatest(input.$repeatedPassword, input.registerTrigger)
            .map { $0.0 }
            .map { $0 == input.password }
//            .map(LoginDto.validateRepeatedPassword(input.repeatedPassword, password: input.password))
        
        repeatedPasswordValidation
            .asDriver()
            .map { _ in "Two passwords should be the same" }
            .assign(to: \.repeatedPasswordValidationMessage, on: output)
            .store(in: cancelBag)
        
        Publishers
            .CombineLatest3(usernameValidation, passwordValidation, repeatedPasswordValidation)
            .map { $0.0.isValid && $0.1.isValid && $0.2}
            .assign(to: \.isRegisterEnabled, on: output)
            .store(in: cancelBag)
        
        input.registerTrigger
            .delay(for: 0.1, scheduler: RunLoop.main)  // waiting for username/password validation
            .filter { output.isRegisterEnabled }
            .map { _ in
                self.useCase.register(dto: RegisterDto(username: input.username.removePlusFromPhoneNumber(), password: input.password, repeatedPassword: input.repeatedPassword))
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { bool in
                if bool {
                    navigator.showCodeInput(title: "Registration")
                }
            })
            .store(in: cancelBag)
        
        input.showLoginTrigger
            .sink {
                navigator.showLogin()
            }
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
            
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
