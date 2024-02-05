//
//  RegisterAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 27/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import UIKit

protocol RegisterAssembler {
    func resolve(navigationController: UINavigationController) -> RegisterView
    func resolve(navigationController: UINavigationController) -> RegisterViewModel
    func resolve(navigationController: UINavigationController) -> RegisterNavigatorType
    func resolve() -> RegisterUseCaseType
}

extension RegisterAssembler {
    func resolve(navigationController: UINavigationController) -> RegisterView {
        RegisterView(viewModel: resolve(navigationController: navigationController))
    }
    
    func resolve(navigationController: UINavigationController) -> RegisterViewModel {
        RegisterViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension RegisterAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> RegisterNavigatorType {
        RegisterNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> RegisterUseCaseType {
        RegisterUseCase(registerGateway: resolve())
    }
}

extension RegisterAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> RegisterNavigatorType {
        RegisterNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> RegisterUseCaseType {
        RegisterUseCase(registerGateway: resolve())
    }
}
