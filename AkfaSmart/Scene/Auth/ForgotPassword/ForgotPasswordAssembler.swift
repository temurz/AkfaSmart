//
//  ForgotPasswordAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 18/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol ForgotPasswordAssembler {
    func resolve(navigationController: UINavigationController) -> ForgotPasswordView
    func resolve(navigationController: UINavigationController) -> ForgotPasswordViewModel
    func resolve(navigationController: UINavigationController) -> ForgotPasswordNavigatorType
    func resolve() -> ForgotPasswordUseCaseType
}

extension ForgotPasswordAssembler {
    func resolve(navigationController: UINavigationController) -> ForgotPasswordView {
        return ForgotPasswordView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> ForgotPasswordViewModel {
        return ForgotPasswordViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve())
    }
}

extension ForgotPasswordAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> ForgotPasswordNavigatorType {
        return ForgotPasswordNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> ForgotPasswordUseCaseType {
        return ForgotPasswordUseCase(forgotPasswordGateway: resolve())
    }
}

extension ForgotPasswordAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> ForgotPasswordNavigatorType {
        return ForgotPasswordNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> ForgotPasswordUseCaseType {
        return ForgotPasswordUseCase(forgotPasswordGateway: resolve())
    }
}
