//
//  ResetPasswordViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 21/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import Combine
struct ResetPasswordViewModel {
    let useCase: ResetPasswordUseCaseType
    let navigator: ResetPasswordNavigatorType
}

extension ResetPasswordViewModel: ViewModel {
    struct Input {
        let resetPasswordTrigger: Driver<Void>
        let popViewControllerTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var password = ""
        @Published var repeatedPassword = ""
        @Published var alert = AlertMessage()
        @Published var passwordValidationMessage = ""
        @Published var repeatedPasswordValidationMessage = ""
        @Published var isResetEnabled = false
        @Published var isLoading = false
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        
        let output = Output()
        
        let passwordValidation = Publishers
            .CombineLatest(output.$password, input.resetPasswordTrigger)
            .map { $0.0 }
            .map(RegisterDto.validatePassword(_:))
        
        passwordValidation
            .map { $0.message }
            .assign(to: \.passwordValidationMessage, on: output)
            .store(in: cancelBag)
        
        let repeatedPasswordValidation = Publishers
            .CombineLatest(output.$repeatedPassword, input.resetPasswordTrigger)
            .map { $0.0 }
            .map {
                $0 == output.password && !$0.isEmpty
            }
        
        repeatedPasswordValidation
            .asDriver()
            .map { bool in
                return bool ? "" : "PASSWORDS_SHOULD_BE_SAME".localizedString
            }
            .assign(to: \.repeatedPasswordValidationMessage, on: output)
            .store(in: cancelBag)
        
        Publishers
            .CombineLatest(passwordValidation, repeatedPasswordValidation)
            .map { $0.0.isValid && $0.1 }
            .assign(to: \.isResetEnabled, on: output)
            .store(in: cancelBag)
        
        input.resetPasswordTrigger
            .delay(for: 0.1, scheduler: RunLoop.main)
            .filter { output.isResetEnabled }
            .map {
                useCase.resetPassword(newPassword: output.password)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { bool in
                if bool {
                    navigator.showLogin()
                }
            })
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
        
        input.popViewControllerTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)
        
        return output
    }
}
