//
//  InfographicsAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol InfographicsAssembler {
    func resolve(navigationController: UINavigationController) -> InfographicsView
    func resolve(navigationController: UINavigationController) -> InfographicsViewModel
    func resolve(navigationController: UINavigationController) -> InfographicsViewNavigatorType
    func resolve() -> InfographicsViewUseCaseType
}

extension InfographicsAssembler {
    func resolve(navigationController: UINavigationController) -> InfographicsView {
        return InfographicsView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> InfographicsViewModel {
        return InfographicsViewModel(useCase: resolve(), navigator: resolve(navigationController: navigationController))
    }
}

extension InfographicsAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> InfographicsViewNavigatorType {
        return InfographicsViewNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> InfographicsViewUseCaseType {
        return InfographicsViewUseCase(gateway: resolve())
    }
}

extension InfographicsAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> InfographicsViewNavigatorType {
        return InfographicsViewNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> InfographicsViewUseCaseType {
        return InfographicsViewUseCase(gateway: resolve())
    }
}
