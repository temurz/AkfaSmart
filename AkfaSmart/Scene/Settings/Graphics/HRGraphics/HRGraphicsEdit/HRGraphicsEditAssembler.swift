//
//  HRGraphicsEditAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol HRGraphicsEditAssembler {
    func resolve(navigationController: UINavigationController, model: HRGraphics) -> HRGraphicsEditView
    func resolve(navigationController: UINavigationController) -> HRGraphicsEditViewModel
    func resolve() -> HRGraphicsEditViewUseCaseType
}

extension HRGraphicsEditAssembler {
    func resolve(navigationController: UINavigationController, model: HRGraphics) -> HRGraphicsEditView {
        return HRGraphicsEditView(viewModel: resolve(navigationController: navigationController), model: model)
    }
    func resolve(navigationController: UINavigationController) -> HRGraphicsEditViewModel {
        return HRGraphicsEditViewModel(useCase: resolve(), navigator: PopViewNavigator(navigationController: navigationController))
    }
}

extension HRGraphicsEditAssembler where Self: DefaultAssembler {
    func resolve() -> HRGraphicsEditViewUseCaseType {
        return HRGraphicsEditViewUseCase(gateway: resolve())
    }
}

extension HRGraphicsEditAssembler where Self: PreviewAssembler {
    func resolve() -> HRGraphicsEditViewUseCaseType {
        return HRGraphicsEditViewUseCase(gateway: resolve())
    }
}
