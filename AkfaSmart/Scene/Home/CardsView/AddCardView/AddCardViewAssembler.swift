//
//  AddCardViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 28/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol AddCardViewAssembler {
    func resolve(navigationController: UINavigationController) -> AddCardView
    func resolve(navigationController: UINavigationController) -> AddCardViewModel
    func resolve(navigationController: UINavigationController) -> AddCardViewNavigatorType
    func resolve() -> AddCardViewUseCaseType
}

extension AddCardViewAssembler {
    func resolve(navigationController: UINavigationController) -> AddCardView {
        return AddCardView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> AddCardViewModel {
        return AddCardViewModel(addCardUseCase: resolve(), navigator: resolve(navigationController: navigationController))
    }
}

extension AddCardViewAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> AddCardViewNavigatorType {
        return AddCardViewNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> AddCardViewUseCaseType {
        return AddCardViewUseCase(gateway: resolve())
    }
}

extension AddCardViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> AddCardViewNavigatorType {
        return AddCardViewNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> AddCardViewUseCaseType {
        return AddCardViewUseCase(gateway: resolve())
    }
}
