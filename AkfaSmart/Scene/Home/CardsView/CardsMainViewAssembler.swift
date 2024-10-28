//
//  CardsMainViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 28/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol CardsMainViewAssembler {
    func resolve(navigationController: UINavigationController) -> CardsMainView
    func resolve(navigationController: UINavigationController) -> CardsMainViewModel
    func resolve(navigationController: UINavigationController) -> CardsMainViewNavigatorType
}

extension CardsMainViewAssembler {
    func resolve(navigationController: UINavigationController) -> CardsMainView {
        return CardsMainView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> CardsMainViewModel {
        return CardsMainViewModel(navigator: resolve(navigationController: navigationController), getCardsUseCase: GetCardsViewUseCase(gateway: GetCardsGateway()))
    }
}

extension CardsMainViewAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> CardsMainViewNavigatorType {
        return CardsMainViewNavigator(assembler: self, navigationController: navigationController)
    }
}

extension CardsMainViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CardsMainViewNavigatorType {
        return CardsMainViewNavigator(assembler: self, navigationController: navigationController)
    }
}
