//
//  CreateOrderAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 06/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol CreateOrderAssembler {
    func resolve(navigationController: UINavigationController) -> CreateOrderView
    func resolve(navigationController: UINavigationController) -> CreateOrderViewModel
    func resolve(navigationController: UINavigationController) -> CreateOrderNavigatorType
    func resolve() -> CreateOrderUseCaseType
}

extension CreateOrderAssembler {
    func resolve(navigationController: UINavigationController) -> CreateOrderView {
        return CreateOrderView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> CreateOrderViewModel {
        return CreateOrderViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve())
    }
}

extension CreateOrderAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CreateOrderNavigatorType {
        return CreateOrderNavigator()
    }
    func resolve() -> CreateOrderUseCaseType {
        return CreateOrderUseCase()
    }
}

extension CreateOrderAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> CreateOrderNavigatorType {
        return CreateOrderNavigator()
    }
    func resolve() -> CreateOrderUseCaseType {
        return CreateOrderUseCase()
    }
}
