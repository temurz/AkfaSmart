//
//  NewsAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol NewsAssembler {
    func resolve(navigationController: UINavigationController) -> NewsView
    func resolve(navigationController: UINavigationController) -> NewsViewModel
    func resolve(navigationController: UINavigationController) -> NewsNavigatorType
    func resolve() -> NewsUseCaseType
    
}

extension NewsAssembler {
    func resolve(navigationController: UINavigationController) -> NewsView {
        let view = NewsView(viewModel: resolve(navigationController: navigationController))
        return view
    }
    
    func resolve(navigationController: UINavigationController) -> NewsViewModel {
        return NewsViewModel(navigator: resolve(navigationController: navigationController))
    }

}

extension NewsAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> NewsNavigatorType {
        return NewsNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> NewsUseCaseType {
        return NewsUseCase()
    }

}

extension NewsAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> NewsNavigatorType {
        return NewsNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> NewsUseCaseType {
        return NewsUseCase()
    }
}
