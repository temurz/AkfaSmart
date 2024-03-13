//
//  EditInfographicsViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 12/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit

protocol EditInfographicsViewAssembler {
    func resolve(navigationController: UINavigationController, model: Infographics) -> EditInfographicsView
    func resolve(navigationController: UINavigationController) -> EditInfographicsViewModel
    func resolve(navigationController: UINavigationController) -> EditInfoGraphicsViewNavigatorType
    func resolve() -> EditInfographicsViewUseCaseType
}

extension EditInfographicsViewAssembler {
    func resolve(navigationController: UINavigationController, model: Infographics) -> EditInfographicsView {
        return EditInfographicsView(viewModel: resolve(navigationController: navigationController), model: model)
    }
    func resolve(navigationController: UINavigationController) -> EditInfographicsViewModel {
        return EditInfographicsViewModel(useCase: resolve(), navigator: resolve(navigationController: navigationController))
    }
}

extension EditInfographicsViewAssembler where Self: DefaultAssembler {
    func resolve() -> EditInfographicsViewUseCaseType {
        return EditInfographicsViewUseCase(gateway: resolve())
    }
    
    func resolve(navigationController: UINavigationController) -> EditInfoGraphicsViewNavigatorType {
        return EditInfoGraphicsViewNavigator(navigationController: navigationController)
    }
}

extension EditInfographicsViewAssembler where Self: PreviewAssembler {
    func resolve() -> EditInfographicsViewUseCaseType {
        return EditInfographicsViewUseCase(gateway: resolve())
    }
    
    func resolve(navigationController: UINavigationController) -> EditInfoGraphicsViewNavigatorType {
        return EditInfoGraphicsViewNavigator(navigationController: navigationController)
    }
}
