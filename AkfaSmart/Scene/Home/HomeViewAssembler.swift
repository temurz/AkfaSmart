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
    func resolve() -> MobileClassUseCaseType
    func resolve() -> GetCardsViewUseCaseType
}

extension HomeViewAssembler {
    func resolve(navigationController: UINavigationController) -> HomeView {
        return HomeView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> HomeViewModel {
        return HomeViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve(), mobileClassUseCase: resolve(), getCardsUseCase: resolve())
    }
}

extension HomeViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> HomeViewNavigatorType {
        return HomeViewNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> HomeViewUseCaseType {
        return HomeViewUseCase(gateway: resolve())
    }
    
    func resolve() -> MobileClassUseCaseType {
        return MobileClassUseCase(gateway: resolve())
    }
    
    func resolve() -> GetCardsViewUseCaseType {
        return GetCardsViewUseCase(gateway: resolve())
    }
}

extension HomeViewAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> HomeViewNavigatorType {
        return HomeViewNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> HomeViewUseCaseType {
        return HomeViewUseCase(gateway: resolve())
    }
    
    func resolve() -> MobileClassUseCaseType {
        return MobileClassUseCase(gateway: resolve())
    }
    
    func resolve() -> GetCardsViewUseCaseType {
        return GetCardsViewUseCase(gateway: resolve())
    }
}
