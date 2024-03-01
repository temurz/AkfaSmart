//
//  CreateOrderAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 06/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol SearchProductViewAssembler {
    func resolve(navigationController: UINavigationController) -> SearchProductView
    func resolve(navigationController: UINavigationController) -> SearchProductViewModel
    func resolve(navigationController: UINavigationController) -> SearchProductViewNavigatorType
    func resolve() -> SearchProductViewUseCaseType
}

extension SearchProductViewAssembler {
    func resolve(navigationController: UINavigationController) -> SearchProductView {
        return SearchProductView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> SearchProductViewModel {
        return SearchProductViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve())
    }
}

extension SearchProductViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> SearchProductViewNavigatorType {
        return SearchProductViewNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> SearchProductViewUseCaseType {
        return SearchProductViewUseCase(gateway: resolve())
    }
}

extension SearchProductViewAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> SearchProductViewNavigatorType {
        return SearchProductViewNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> SearchProductViewUseCaseType {
        return SearchProductViewUseCase(gateway: resolve())
    }
}
