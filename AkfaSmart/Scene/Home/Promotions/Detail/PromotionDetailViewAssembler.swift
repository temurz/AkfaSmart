//
//  PromotionDetailViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 18/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import UIKit

protocol PromotionDetailViewAssembler {
    func resolve(promotion: Promotion, navigationController: UINavigationController) -> PromotionDetailView
    func resolve(promotion: Promotion, navigationController: UINavigationController) -> PromotionDetailViewModel
    func resolve(navigationController: UINavigationController) -> PromotionDetailNavigatorType
}

extension PromotionDetailViewAssembler {
    func resolve(promotion: Promotion, navigationController: UINavigationController) -> PromotionDetailView {
        PromotionDetailView(viewModel: resolve(promotion: promotion, navigationController: navigationController))
    }
    func resolve(promotion: Promotion, navigationController: UINavigationController) -> PromotionDetailViewModel {
        PromotionDetailViewModel(promotion: promotion, navigator: resolve(navigationController: navigationController))
    }
    
}

extension PromotionDetailViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> PromotionDetailNavigatorType {
        PromotionDetailNavigator(assembler: self, navigationController: navigationController)
    }
}

extension PromotionDetailViewAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> PromotionDetailNavigatorType {
        PromotionDetailNavigator(assembler: self, navigationController: navigationController)
    }
}
