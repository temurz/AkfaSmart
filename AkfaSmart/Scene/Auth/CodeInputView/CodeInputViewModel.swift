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
    private let showAlertTrigger = PassthroughSubject<Void, Never>()
}

// MARK: - ViewModelType
extension CodeInputViewModel: ViewModel {
    final class Input: ObservableObject {
        @Published var code = ""
        let confirmRegisterTrigger: Driver<Void>
        let resendSMSTrigger: Driver<Void>
        let showMainViewTrigger: Driver<Void>
        let confirmActiveUserTrigger: Driver<Void>
        
        init(confirmRegisterTrigger: Driver<Void>, resendSMSTrigger: Driver<Void>, showMainViewTrigger: Driver<Void>, confirmActiveUserTrigger: Driver<Void>) {
            self.confirmRegisterTrigger = confirmRegisterTrigger
            self.resendSMSTrigger = resendSMSTrigger
            self.showMainViewTrigger = showMainViewTrigger
            self.confirmActiveUserTrigger = confirmActiveUserTrigger
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
        @Published var showConfirmAlert = false
        var activeUsername: String? = nil
        var dealer: AddDealer? = nil
        var isActive: Bool = false
        
        init(reason: CodeReason) {
            self.reason = reason
            switch reason {
            case .register:
                title = "REGISTRATION".localizedString
            case .forgotPassword:
                title = "FORGOT_PASSWORD".localizedString
            case let .dealer(dealer, activeUsername, isActive):
                title = "ADD_DEALER".localizedString
                username = dealer.phone?.removeWhitespacesFromString().makeStarsInsteadNumbersInUsername() ?? ""
                self.dealer = dealer
                self.activeUsername = activeUsername
                self.isActive = isActive
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
        
        if !output.isActive {
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
                    case let .dealer(dealer,_, _):
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
                            navigator.showPINCodeView(state: .onAuth)
                        case .forgotPassword:
                            navigator.showResetPasswordView()
                        case .dealer(_,_,_):
                            navigator.showMain(page: .home)
                        }
                    }
                }
                .store(in: cancelBag)
        }else {
            input.confirmRegisterTrigger
                .delay(for: 0.1, scheduler: RunLoop.main)
                .filter { output.isConfirmEnabled }
                .map { _ in
                    switch reason {
                    case .dealer:
                        output.showConfirmAlert = true
                    default:
                        break
                    }
                }
                .sink()
                .store(in: cancelBag)
        }
        
        input.confirmActiveUserTrigger
            .map { _ in
                if let dealer = output.dealer {
                    self.dealerUseCase.confirmSMSCodeForActiveDealer(dealer, code: input.code)
                        .trackError(errorTracker)
                        .trackActivity(activityTracker)
                        .asDriver()
                        .map({ bool in
                            navigator.showMain(page: .home)
                        })
                        .sink()
                        .store(in: cancelBag)
                }
            }
            .sink()
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
            .map {
                if let error = $0 as? APIUnknownError, error.status == 702 {
                    switch output.reason {
                    case let .dealer(dealer,_,_):
                        dealerUseCase.requestSMSCodeForActiveDealer(dealer)
                            .trackError(errorTracker)
                            .trackActivity(activityTracker)
                            .asDriver()
                            .map { dealerInfo in
                                output.timeRemaining = 120
                            }
                            .sink()
                            .store(in: cancelBag)
                    default:
                        break
                    }
                    return AlertMessage()
                }else {
                    var alert = AlertMessage(error: $0)
                    alert.isShowing = true
                    return alert
                }
            }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
            
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
