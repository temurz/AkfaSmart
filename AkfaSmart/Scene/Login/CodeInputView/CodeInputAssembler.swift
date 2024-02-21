//
//  CodeInputAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol CodeInputAssembler {
    func resolve(navigationController: UINavigationController, reason: CodeReason) -> CodeInputView
    func resolve(navigationController: UINavigationController, reason: CodeReason) -> CodeInputViewModel
    func resolve(navigationController: UINavigationController) -> CodeInputNavigatorType
    func resolve() -> CodeInputUseCaseType
    func resolve() -> ResendSMSUseCaseType
    func resolve() -> ConfirmSMSCodeOnForgotPasswordUseCaseType

}

extension CodeInputAssembler {
    func resolve(navigationController: UINavigationController, reason: CodeReason) -> CodeInputView {
        return CodeInputView(viewModel: resolve(navigationController: navigationController, reason: reason))
    }
    
    func resolve(navigationController: UINavigationController, reason: CodeReason) -> CodeInputViewModel {
        return CodeInputViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            useCaseResend: resolve(),
            confirmSMSCodeOnForgotPasswordUseCase: resolve(),
            reason: reason)
    }
}

extension CodeInputAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CodeInputNavigatorType {
        return CodeInputNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> CodeInputUseCaseType {
        return CodeInputUseCase(codeInputGateway: resolve())
    }
    
    func resolve() -> ResendSMSUseCaseType {
        return ResendSMSUseCase(resendSMSGateway: resolve())
    }
    func resolve() -> ConfirmSMSCodeOnForgotPasswordUseCaseType {
        return ConfirmSMSCodeOnForgotPasswordUseCase(confirmSMSCodeOnForgotPasswordGateway: resolve())
    }
}

extension CodeInputAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> CodeInputNavigatorType {
        return CodeInputNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> CodeInputUseCaseType {
        return CodeInputUseCase(codeInputGateway: resolve())
    }
    
    func resolve() -> ResendSMSUseCaseType {
        return ResendSMSUseCase(resendSMSGateway: resolve())
    }
    
    func resolve() -> ConfirmSMSCodeOnForgotPasswordUseCaseType {
        return ConfirmSMSCodeOnForgotPasswordUseCase(confirmSMSCodeOnForgotPasswordGateway: resolve())
    }
}
