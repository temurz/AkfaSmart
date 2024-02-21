//
//  ResetPasswordAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 21/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol ResetPasswordAssembler {
    func resolve(navigationController: UINavigationController) -> ResetPasswordView
    func resolve(navigationController: UINavigationController) -> ResetPasswordViewModel
    func resolve(navigationController: UINavigationController) -> ResetPasswordNavigatorType
    func resolve() -> ResetPasswordUseCaseType
}

extension ResetPasswordAssembler {
    func resolve(navigationController: UINavigationController) -> ResetPasswordView {
        return ResetPasswordView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> ResetPasswordViewModel {
        return ResetPasswordViewModel(useCase: resolve(), navigator: resolve(navigationController: navigationController))
    }
}

extension ResetPasswordAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> ResetPasswordNavigatorType {
        return ResetPasswordNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> ResetPasswordUseCaseType {
        ResetPasswordUseCase(resetPasswordGateway: resolve())
    }
}

extension ResetPasswordAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> ResetPasswordNavigatorType {
        return ResetPasswordNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> ResetPasswordUseCaseType {
        ResetPasswordUseCase(resetPasswordGateway: resolve())
    }
}
