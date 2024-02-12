//
//  WelcomeViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol WelcomeViewAssembler {
    func resolve(navigationController: UINavigationController) -> WelcomeView
    func resolve(navigationController: UINavigationController) -> WelcomeViewModel
    func resolve(navigationController: UINavigationController) -> WelcomeViewNavigatorType
}

extension WelcomeViewAssembler {
    func resolve(navigationController: UINavigationController) -> WelcomeView {
        return WelcomeView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> WelcomeViewModel {
        return WelcomeViewModel(navigator: resolve(navigationController: navigationController))
    }
}

extension WelcomeViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> WelcomeViewNavigatorType {
        return WelcomeViewNavigator(assembler: self, navigationController: navigationController)
    }
}

extension WelcomeViewAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> WelcomeViewNavigatorType {
        return WelcomeViewNavigator(assembler: self, navigationController: navigationController)
    }
}
