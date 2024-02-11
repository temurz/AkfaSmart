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
    let title: String
}

// MARK: - ViewModelType
extension CodeInputViewModel: ViewModel {
    final class Input: ObservableObject {
        @Published var code = ""
        let confirmRegisterTrigger: Driver<Void>
        
        
        init(confirmRegisterTrigger: Driver<Void>) {
            self.confirmRegisterTrigger = confirmRegisterTrigger
            
        }
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var codeValidationMessage = ""
        @Published var title: String
        @Published var isConfirmEnabled = true
        
        init(title: String) {
            self.title = title
        }
    }
        
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output(title: self.title)
        
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
                self.useCase.confirmRegister(dto: CodeInputDto(code: input.code))
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink { bool in
                if bool {
                    navigator.showMain()
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
