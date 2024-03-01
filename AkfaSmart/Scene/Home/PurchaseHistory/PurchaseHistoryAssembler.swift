//
//  PurchaseHistoryAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit

protocol PurchaseHistoryAssembler {
    func resolve(navigationController: UINavigationController) -> PurchaseHistoryView
    func resolve(navigationController: UINavigationController) -> PurchaseHistoryViewModel
    func resolve(navigationController: UINavigationController) -> PurchaseHistoryViewNavigatorType
    func resolve() -> PurchaseHistoryViewUseCaseType
}

extension PurchaseHistoryAssembler {
    func resolve(navigationController: UINavigationController) -> PurchaseHistoryView {
        return PurchaseHistoryView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> PurchaseHistoryViewModel {
        return PurchaseHistoryViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve())
    }
}

extension PurchaseHistoryAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> PurchaseHistoryViewNavigatorType {
        return PurchaseHistoryViewNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> PurchaseHistoryViewUseCaseType {
        return PurchaseHistoryViewUseCase(gateway: resolve())
    }
}

extension PurchaseHistoryAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> PurchaseHistoryViewNavigatorType {
        return PurchaseHistoryViewNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> PurchaseHistoryViewUseCaseType {
        return PurchaseHistoryViewUseCase(gateway: resolve())
    }
}
