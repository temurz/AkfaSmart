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
    let dealerUseCase: ConfirmDealerUseCaseType
    let reason: CodeReason
}

// MARK: - ViewModelType
extension CodeInputViewModel: ViewModel {
    final class Input: ObservableObject {
        @Published var code = ""
        let confirmRegisterTrigger: Driver<Void>
        let resendSMSTrigger: Driver<Void>
        let showMainViewTrigger: Driver<Void>
        
        init(confirmRegisterTrigger: Driver<Void>, resendSMSTrigger: Driver<Void>, showMainViewTrigger: Driver<Void>) {
            self.confirmRegisterTrigger = confirmRegisterTrigger
            self.resendSMSTrigger = resendSMSTrigger
            self.showMainViewTrigger = showMainViewTrigger
        }
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var codeValidationMessage = ""
        @Published var timeRemaining = 120
        @Published var username: String =  AuthApp.shared.username?.makeStarsInsteadNumbersInUsername() ?? ""
        @Published var title: String
        @Published var isConfirmEnabled = true
        @Published var reason: CodeReason
        
        init(reason: CodeReason) {
            self.reason = reason
            switch reason {
            case .register:
                title = "REGISTRATION".localizedString
            case .forgotPassword:
                title = "FORGOT_PASSWORD".localizedString
            case let .dealer(dealer):
                title = "ADD_DEALER".localizedString
                username = dealer.phone?.makeStarsInsteadNumbersInUsername() ?? ""
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
        
        input.showMainViewTrigger.sink {
            navigator.showMain(page: .home)
        }
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
                case let .dealer(dealer):
                    self.dealerUseCase.confirmSMSCode(dealer, code: input.code)
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
                        navigator.showMain(page: .home)
                    case .forgotPassword:
                        navigator.showResetPasswordView()
                    case .dealer(_):
                        navigator.showMain(page: .home)
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
                if bool {
                    output.timeRemaining = 120
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
