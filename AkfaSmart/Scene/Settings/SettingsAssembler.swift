//
//  SettingsAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol SettingsAssembler {
    func resolve(navigationController: UINavigationController) -> SettingsView
    func resolve(navigationController: UINavigationController) -> SettingsViewModel
    func resolve(navigationController: UINavigationController) -> SettingsNavigatorType
    func resolve() -> SettingsUseCaseType
}

extension SettingsAssembler {
    func resolve(navigationController: UINavigationController) -> SettingsView {
        return SettingsView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> SettingsViewModel {
        return SettingsViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve())
    }
}

extension SettingsAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> SettingsNavigatorType {
        return SettingsNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> SettingsUseCaseType {
        return SettingsUseCase()
    }
}

extension SettingsAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> SettingsNavigatorType {
        return SettingsNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> SettingsUseCaseType {
        return SettingsUseCase()
    }
}
