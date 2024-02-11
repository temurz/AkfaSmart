//
//  ArticlesAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol ArticlesAssembler {
    func resolve(navigationController: UINavigationController) -> ArticlesView
    func resolve(navigationController: UINavigationController) -> ArticlesViewModel
    func resolve(navigationController: UINavigationController) -> ArticlesNavigatorType
    func resolve() -> ArticlesUseCaseType
}

extension ArticlesAssembler {
    func resolve(navigationController: UINavigationController) -> ArticlesView {
        return ArticlesView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> ArticlesViewModel {
        return ArticlesViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve())
    }

}

extension ArticlesAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> ArticlesNavigatorType {
        return ArticlesNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> ArticlesUseCaseType {
        return ArticlesUseCase(articlesGateway: resolve())
    }
}

extension ArticlesAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> ArticlesNavigatorType {
        return ArticlesNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> ArticlesUseCaseType {
        return ArticlesUseCase(articlesGateway: resolve())
    }
}
