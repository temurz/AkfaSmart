//
//  CodeInputViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import Combine
struct CodeInputViewModel {
    let navigator: CodeInputNavigatorType
    let useCase: CodeInputUseCaseType
    let useCaseResend: ResendSMSUseCaseType
    let confirmSMSCodeOnForgotPasswordUseCase: ConfirmSMSCodeOnForgotPasswordUseCaseType
    let reason: CodeReason
}

// MARK: - ViewModelType
extension CodeInputViewModel: ViewModel {
    final class Input: ObservableObject {
        @Published var code = ""
        let confirmRegisterTrigger: Driver<Void>
        let resendSMSTrigger: Driver<Void>
        
        init(confirmRegisterTrigger: Driver<Void>, resendSMSTrigger: Driver<Void>) {
            self.confirmRegisterTrigger = confirmRegisterTrigger
            self.resendSMSTrigger = resendSMSTrigger
        }
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var codeValidationMessage = ""
        @Published var title: String
        @Published var isConfirmEnabled = true
        
        init(reason: CodeReason) {
            switch reason {
            case .register:
                title = "Registration"
            case .forgotPassword:
                title = "Forgot password"
            }
        }
    }
        
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output(reason: self.reason)
        
        let codeValidationMessage = Publishers
            .CombineLatest(input.$code, input.confirmRegisterTrigger)
            .map { $0.0 }
            .map(CodeInputDto.validateCode(_:))
        
        codeValidationMessage
            .asDriver()
            .map { $0.message }
            .assign(to: \.codeValidationMessage, on: output)
            .store(in: cancelBag)
        
        codeValidationMessage
            .map { $0.isValid }
            .assign(to: \.isConfirmEnabled, on: output)
            .store(in: cancelBag)
        
        input.confirmRegisterTrigger
            .delay(for: 0.1, scheduler: RunLoop.main)
            .filter { output.isConfirmEnabled }
            .map { _ in
                switch reason {
                case .register:
                    self.useCase.confirmRegister(dto: CodeInputDto(code: input.code))
                        .trackError(errorTracker)
                        .trackActivity(activityTracker)
                        .asDriver()
                case .forgotPassword:
                    self.confirmSMSCodeOnForgotPasswordUseCase.confirmSMSCodeOnForgotPassword(dto: CodeInputDto(code: input.code))
                        .trackError(errorTracker)
                        .trackActivity(activityTracker)
                        .asDriver()
                }
            }
            .switchToLatest()
            .sink { bool in
                if bool {
                    switch reason {
                    case .register:
                        navigator.showMain()
                    case .forgotPassword:
                        //TODO: 
                        navigator.showResetPasswordView()
                    }
                }
            }
            .store(in: cancelBag)
        
        input.resendSMSTrigger
            .map { _ in
                self.useCaseResend.resendSMS(reason: reason)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink { bool in
                if !bool {
                    //show error
                }
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
