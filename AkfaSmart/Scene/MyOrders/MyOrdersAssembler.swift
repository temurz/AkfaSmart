//
//  MyOrdersAssembler.swift
//  AkfaSmart
//

import UIKit
protocol MyOrdersAssembler {
    func resolve(navigationController: UINavigationController) -> MyOrdersView
    func resolve(navigationController: UINavigationController) -> MyOrdersViewModel
    func resolve(navigationController: UINavigationController) -> MyOrdersViewNavigatorType
    func resolve() -> MyOrdersViewUseCaseType
}

extension MyOrdersAssembler {
    func resolve(navigationController: UINavigationController) -> MyOrdersView {
        return MyOrdersView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> MyOrdersViewModel {
        return MyOrdersViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve())
    }
}

extension MyOrdersAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> MyOrdersViewNavigatorType {
        return MyOrdersViewNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> MyOrdersViewUseCaseType {
        return MyOrdersViewUseCase(gateway: resolve())
    }
}

extension MyOrdersAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> MyOrdersViewNavigatorType {
        return MyOrdersViewNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> MyOrdersViewUseCaseType {
        return MyOrdersViewUseCase(gateway: resolve())
    }
}
