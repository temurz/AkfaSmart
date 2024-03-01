//
//  ProductDealersListViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ProductDealersListViewAssembler {
    func resolve(model: ProductWithName) -> ProductDealersListView
    func resolve() -> ProductDealersListViewModel
    func resolve() -> ProductDealersListViewUseCaseType
}

extension ProductDealersListViewAssembler {
    func resolve(model: ProductWithName) -> ProductDealersListView {
        return ProductDealersListView(model: model, viewModel: resolve())
    }
    func resolve() -> ProductDealersListViewModel {
        return ProductDealersListViewModel(useCase: resolve())
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
