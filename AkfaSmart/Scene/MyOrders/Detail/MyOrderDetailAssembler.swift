//
//  MyOrderDetailAssembler.swift
//  AkfaSmart
//

import UIKit
protocol MyOrderDetailAssembler {
    func resolve(model: OrderSummary, navigationController: UINavigationController) -> MyOrderDetailView
    func resolve(model: OrderSummary, navigationController: UINavigationController) -> MyOrderDetailViewModel
    func resolve() -> MyOrderDetailViewUseCaseType
}

extension MyOrderDetailAssembler {
    func resolve(model: OrderSummary, navigationController: UINavigationController) -> MyOrderDetailView {
        return MyOrderDetailView(model: model, viewModel: resolve(model: model, navigationController: navigationController))
    }
    func resolve(model: OrderSummary, navigationController: UINavigationController) -> MyOrderDetailViewModel {
        return MyOrderDetailViewModel(model: model, useCase: resolve(), navigator: PopViewNavigator(navigationController: navigationController))
    }
}

extension MyOrderDetailAssembler where Self: DefaultAssembler {
    func resolve() -> MyOrderDetailViewUseCaseType {
        return MyOrderDetailViewUseCase(gateway: resolve())
    }
}

extension MyOrderDetailAssembler where Self: PreviewAssembler {
    func resolve() -> MyOrderDetailViewUseCaseType {
        return MyOrderDetailViewUseCase(gateway: resolve())
    }
}
