//
//  PurchaseDetailViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol PurchaseDetailViewAssembler {
    func resolve(model: Invoice, navigationController: UINavigationController) -> PurchaseDetailView
    func resolve(navigationController: UINavigationController) -> PurchaseDetailViewModel
    func resolve() -> PurchaseDetailViewUseCaseType
}

extension PurchaseDetailViewAssembler {
    func resolve(model: Invoice, navigationController: UINavigationController) -> PurchaseDetailView {
        return PurchaseDetailView(model: model, viewModel: resolve(navigationController: navigationController))
    }
    
    func resolve(navigationController: UINavigationController) -> PurchaseDetailViewModel {
        return PurchaseDetailViewModel(useCase: resolve(), navigator: PopViewNavigator(navigationController: navigationController))
    }
}

extension PurchaseDetailViewAssembler where Self: DefaultAssembler {
    func resolve() -> PurchaseDetailViewUseCaseType {
        return PurchaseDetailViewUseCase(gateway: resolve())
    }
}

extension PurchaseDetailViewAssembler where Self: PreviewAssembler {
    func resolve() -> PurchaseDetailViewUseCaseType {
        return PurchaseDetailViewUseCase(gateway: resolve())
    }
}
