//
//  MyCouponsAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 18/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import UIKit

protocol MyCouponsAssembler {
    func resolve(navigationController: UINavigationController) -> MyCouponsView
    func resolve(navigationController: UINavigationController) -> MyCouponsViewModel
    func resolve() -> MyCouponsViewUseCaseType
}

extension MyCouponsAssembler {
    func resolve(navigationController: UINavigationController) -> MyCouponsView {
        return MyCouponsView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> MyCouponsViewModel {
        MyCouponsViewModel(useCase: resolve(), navigator: PopViewNavigator(navigationController: navigationController))
    }
}

extension MyCouponsAssembler where Self: DefaultAssembler {
    func resolve() -> MyCouponsViewUseCaseType {
        MyCouponsViewUseCase(gateway: resolve())
    }
}

extension MyCouponsAssembler where Self: PreviewAssembler {
    func resolve() -> MyCouponsViewUseCaseType {
        MyCouponsViewUseCase(gateway: resolve())
    }
}
