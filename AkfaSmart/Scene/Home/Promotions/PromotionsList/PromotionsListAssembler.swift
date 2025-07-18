//
//  PromotionsListAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 18/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import UIKit

protocol PromotionsListAssembler {
    func resolve(promotions: [Promotion], navigationController: UINavigationController) -> PromotionsListView
    func resolve(promotions: [Promotion], navigationController: UINavigationController) -> PromotionsListViewModel
    func resolve(navigationController: UINavigationController) -> PromotionsListNavigatorType
}

extension PromotionsListAssembler {
    func resolve(promotions: [Promotion], navigationController: UINavigationController) -> PromotionsListView {
        PromotionsListView(viewModel: resolve(promotions: promotions, navigationController: navigationController))
    }
    func resolve(promotions: [Promotion], navigationController: UINavigationController) -> PromotionsListViewModel {
        PromotionsListViewModel(promotions: promotions, navigator: resolve(navigationController: navigationController))
    }
}

extension PromotionsListAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> PromotionsListNavigatorType {
        PromotionsListNavigator(navigationController: navigationController, assembler: self)
    }
}
extension PromotionsListAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> PromotionsListNavigatorType {
        PromotionsListNavigator(navigationController: navigationController, assembler: self)
    }
}
