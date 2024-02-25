//
//  HomeViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol HomeViewAssembler {
    func resolve(navigationController: UINavigationController) -> HomeView
    func resolve(navigationController: UINavigationController) -> HomeViewModel
    func resolve(navigationController: UINavigationController) -> HomeViewNavigatorType
    func resolve() -> HomeViewUseCaseType
}

extension HomeViewAssembler {
    func resolve(navigationController: UINavigationController) -> HomeView {
        return HomeView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> HomeViewModel {
        return HomeViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve())
    }
}

extension HomeViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> HomeViewNavigatorType {
        return HomeViewNavigator()
    }
    
    func resolve() -> HomeViewUseCaseType {
        return HomeViewUseCase(gateway: resolve())
    }
}

extension HomeViewAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> HomeViewNavigatorType {
        return HomeViewNavigator()
    }
    
    func resolve() -> HomeViewUseCaseType {
        return HomeViewUseCase(gateway: resolve())
    }
}
