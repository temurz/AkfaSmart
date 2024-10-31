//
//  CodeInputAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol CodeInputAssembler {
    func resolve(navigationController: UINavigationController, reason: CodeReason, isModal: Bool, completion: ((Bool) -> Void)?) -> CodeInputView
    func resolve(navigationController: UINavigationController, reason: CodeReason) -> CodeInputViewModel
    func resolve(navigationController: UINavigationController) -> CodeInputNavigatorType
    func resolve() -> CodeInputUseCaseType
    func resolve() -> ResendSMSUseCaseType
    func resolve() -> ConfirmSMSCodeOnForgotPasswordUseCaseType
    func resolve() -> ConfirmDealerUseCaseType
    func resolve() -> CardActivationUseCaseType
    func resolve() -> CardConfirmActionUseCaseType
}

extension CodeInputAssembler {
    func resolve(navigationController: UINavigationController, reason: CodeReason, isModal: Bool = false, completion: ((Bool) -> Void)? = nil) -> CodeInputView {
        return CodeInputView(viewModel: resolve(navigationController: navigationController, reason: reason), isModal: isModal, completion: completion)
    }
    
    func resolve(navigationController: UINavigationController, reason: CodeReason) -> CodeInputViewModel {
        return CodeInputViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            useCaseResend: resolve(),
            confirmSMSCodeOnForgotPasswordUseCase: resolve(),
            dealerUseCase: resolve(),
            cardActivationUseCase: resolve(), 
            cardConfirmActionUseCase: resolve(),
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
    func resolve() -> ConfirmDealerUseCaseType {
        return ConfirmDealerUseCase(gateway: AddDealerGateway())
    }

    func resolve() -> CardActivationUseCaseType {
        return CardActivationUseCase(gateway: resolve())
    }
    
    func resolve() -> CardConfirmActionUseCaseType {
        CardConfirmActionUseCase(gateway: resolve())
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
    
    func resolve() -> ConfirmDealerUseCaseType {
        return ConfirmDealerUseCase(gateway: AddDealerGateway())
    }

    func resolve() -> CardActivationUseCaseType {
        return CardActivationUseCase(gateway: resolve())
    }
    
    func resolve() -> CardConfirmActionUseCaseType {
        CardConfirmActionUseCase(gateway: resolve())
    }
}
