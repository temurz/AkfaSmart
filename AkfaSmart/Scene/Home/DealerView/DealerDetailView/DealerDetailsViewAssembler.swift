//
//  DealerDetailsViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 27/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol DealerDetailsViewAssembler {
    func resolve(model: Dealer, navigationController: UINavigationController) -> DealerDetailModalView
    func resolve(navigationController: UINavigationController) -> DealerDetailsViewModel
    func resolve(navigationController: UINavigationController) -> DealerDetailsViewNavigatorType
}

extension DealerDetailsViewAssembler {
    func resolve(model: Dealer, navigationController: UINavigationController) -> DealerDetailModalView {
        return DealerDetailModalView(model: model, viewModel: resolve(navigationController: navigationController))
    }
    
    func resolve(navigationController: UINavigationController) -> DealerDetailsViewModel {
        return DealerDetailsViewModel(navigator: resolve(navigationController: navigationController))
    }
}

extension DealerDetailsViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> DealerDetailsViewNavigatorType {
        return DealerDetailsViewNavigator(assembler: self, navigationController: navigationController)
    }
}

extension DealerDetailsViewAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> DealerDetailsViewNavigatorType {
        return DealerDetailsViewNavigator(assembler: self, navigationController: navigationController)
    }
}
