//
//  SplashViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit

protocol SplashViewAssembler {
    func resolve(navigationController: UINavigationController) -> SplashView
    func resolve(navigationController: UINavigationController) -> SplashViewModel
    func resolve(navigationController: UINavigationController) -> SplashViewNavigatorType
}

extension SplashViewAssembler {
    func resolve(navigationController: UINavigationController) -> SplashView {
        return SplashView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> SplashViewModel {
        return SplashViewModel(navigator: resolve(navigationController: navigationController))
    }
}

extension SplashViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> SplashViewNavigatorType {
        return SplashViewNavigator(assembler: self, navigationController: navigationController)
    }
}

extension SplashViewAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> SplashViewNavigatorType {
        return SplashViewNavigator(assembler: self, navigationController: navigationController)
    }
}
