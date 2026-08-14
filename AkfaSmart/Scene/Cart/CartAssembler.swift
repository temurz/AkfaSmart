//
//  CartAssembler.swift
//  AkfaSmart
//

import UIKit
protocol CartAssembler {
    func resolve(navigationController: UINavigationController) -> CartView
    func resolve(navigationController: UINavigationController) -> CartViewModel
    func resolve() -> CartViewUseCaseType
}

extension CartAssembler {
    func resolve(navigationController: UINavigationController) -> CartView {
        return CartView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> CartViewModel {
        return CartViewModel(useCase: resolve(), navigationController: navigationController)
    }
}

extension CartAssembler where Self: DefaultAssembler {
    func resolve() -> CartViewUseCaseType {
        return CartViewUseCase(gateway: resolve(), orderGateway: resolve())
    }
}

extension CartAssembler where Self: PreviewAssembler {
    func resolve() -> CartViewUseCaseType {
        return CartViewUseCase(gateway: resolve(), orderGateway: resolve())
    }
}
