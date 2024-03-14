//
//  EditTechnographicsAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol EditTechnographicsAssembler {
    func resolve(navigationController: UINavigationController, model: TechnoGraphics) -> EditTechnographicsView
    func resolve(navigationController: UINavigationController) -> EditTechnographicsViewModel
    func resolve(navigationController: UINavigationController) -> EditTechnographicsNavigatorType
    func resolve() -> EditTechnographicsUseCaseType
}

extension EditTechnographicsAssembler {
    func resolve(navigationController: UINavigationController, model: TechnoGraphics) -> EditTechnographicsView {
        return EditTechnographicsView(viewModel: resolve(navigationController: navigationController), model: model)
    }
    
    func resolve(navigationController: UINavigationController) -> EditTechnographicsViewModel {
        return EditTechnographicsViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve())
    }
}

extension EditTechnographicsAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> EditTechnographicsNavigatorType {
        return EditTechnographicsNavigator(navigationController: navigationController)
    }
    func resolve() -> EditTechnographicsUseCaseType {
        return EditTechnographicsUseCase(gateway: resolve())
    }
}

extension EditTechnographicsAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> EditTechnographicsNavigatorType {
        return EditTechnographicsNavigator(navigationController: navigationController)
    }
    func resolve() -> EditTechnographicsUseCaseType {
        return EditTechnographicsUseCase(gateway: resolve())
    }
}
