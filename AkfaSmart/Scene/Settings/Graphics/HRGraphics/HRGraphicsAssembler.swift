//
//  HRGraphicsAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol HRGraphicsAssembler {
    func resolve(navigationController: UINavigationController) -> HRgraphicsView
    func resolve(navigationController: UINavigationController) -> HRgraphicsViewModel
    func resolve(navigationController: UINavigationController) -> HRGraphicsNavigatorType
    func resolve() -> HRGraphicsViewUseCaseType
}

extension HRGraphicsAssembler {
    func resolve(navigationController: UINavigationController) -> HRgraphicsView {
        return HRgraphicsView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> HRgraphicsViewModel {
        return HRgraphicsViewModel(useCase: resolve(), navigator: resolve(navigationController: navigationController))
    }
}

extension HRGraphicsAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> HRGraphicsNavigatorType {
        return HRGraphicsNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> HRGraphicsViewUseCaseType {
        return HRGraphicsViewUseCase(gateway: resolve())
    }
}

extension HRGraphicsAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> HRGraphicsNavigatorType {
        return HRGraphicsNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> HRGraphicsViewUseCaseType {
        return HRGraphicsViewUseCase(gateway: resolve())
    }
}
