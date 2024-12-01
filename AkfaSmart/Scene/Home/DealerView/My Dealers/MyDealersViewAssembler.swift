//
//  MyDealersViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 01/12/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol MyDealersViewAssembler {
    func resolve(dealers: [Dealer], navigationController: UINavigationController) -> MyDealersView
    func resolve(dealers: [Dealer], navigationController: UINavigationController) -> MyDealersViewModel
    func resolve(navigationController: UINavigationController) -> MyDealersViewNavigatorType
    func resolve() -> MyDealersViewUseCaseType
}

extension MyDealersViewAssembler {
    func resolve(dealers: [Dealer], navigationController: UINavigationController) -> MyDealersView {
        return MyDealersView(viewModel: resolve(dealers: dealers, navigationController: navigationController))
    }
    func resolve(dealers: [Dealer], navigationController: UINavigationController) -> MyDealersViewModel {
        return MyDealersViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve(), dealers: dealers)
    }
}

extension MyDealersViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> MyDealersViewNavigatorType {
        return MyDealersViewNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> MyDealersViewUseCaseType {
        return MyDealersViewUseCase(gateway: resolve())
    }
}

extension MyDealersViewAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> MyDealersViewNavigatorType {
        return MyDealersViewNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> MyDealersViewUseCaseType {
        return MyDealersViewUseCase(gateway: resolve())
    }
}
