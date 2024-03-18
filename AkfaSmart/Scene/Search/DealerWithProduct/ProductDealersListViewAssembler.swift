//
//  ProductDealersListViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol ProductDealersListViewAssembler {
    func resolve(model: ProductWithName, navigationController: UINavigationController) -> ProductDealersListView
    func resolve(navigationController: UINavigationController) -> ProductDealersListViewModel
    func resolve() -> ProductDealersListViewUseCaseType
}

extension ProductDealersListViewAssembler {
    func resolve(model: ProductWithName, navigationController: UINavigationController) -> ProductDealersListView {
        return ProductDealersListView(model: model, viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> ProductDealersListViewModel {
        return ProductDealersListViewModel(useCase: resolve(), navigationController: navigationController)
    }
}

extension ProductDealersListViewAssembler where Self: DefaultAssembler {
    func resolve() -> ProductDealersListViewUseCaseType {
        ProductDealersListViewUseCase(gateway: resolve())
    }
}

extension ProductDealersListViewAssembler where Self: PreviewAssembler {
    func resolve() -> ProductDealersListViewUseCaseType {
        ProductDealersListViewUseCase(gateway: resolve())
    }
}
