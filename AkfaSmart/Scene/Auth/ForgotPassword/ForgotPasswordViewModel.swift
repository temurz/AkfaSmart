//
//  ForgotPasswordViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 18/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Combine
import Foundation

struct ForgotPasswordViewModel {
    let navigator: ForgotPasswordNavigatorType
    let useCase: ForgotPasswordUseCaseType
}


extension ForgotPasswordViewModel: ViewModel {
    final class Input: ObservableObject {
        let confirmPhoneNumberTrigger: Driver<Void>
        @Published var phoneNumber = "998"
        
        init(confirmPhoneNumberTrigger: Driver<Void>) {
            self.confirmPhoneNumberTrigger = confirmPhoneNumberTrigger
        }
    }
    
    final class Output: ObservableObject {
        
        @Published var isConformanceAllowed = true
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var usernameValidationMessage = ""
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        let usernameValidation = Publishers
            .CombineLatest(input.$phoneNumber, input.confirmPhoneNumberTrigger)
            .map { $0.0 }
            .map(PhoneNumberDTO.validatePhoneNumber(_:))
        
        usernameValidation
            .asDriver()
            .map { $0.message }
            .assign(to: \.usernameValidationMessage, on: output)
            .store(in: cancelBag)
        
        usernameValidation
            .map { $0.isValid }
            .assign(to: \.isConformanceAllowed, on: output)
            .store(in: cancelBag)
        
        input.confirmPhoneNumberTrigger
            .delay(for: 0.1, scheduler: RunLoop.main)
            .filter { output.isConformanceAllowed }
            .map { _ in
                useCase.requestSMSOnForgotPassword(phoneNumber: input.phoneNumber.getOnlyNumbers())
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { bool in
                if bool {
                    navigator.showCodeInput(reason: .forgotPassword)
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
        
        return output
    }
}
