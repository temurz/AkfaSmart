//
//  PINCodeViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 20/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol PINCodeViewAssembler {
    func resolve(state: PINCodeState, navigationController: UINavigationController) -> PINCodeView
    func resolve(state: PINCodeState, navigationController: UINavigationController) -> PINCodeViewModel
    func resolve(navigationController: UINavigationController) -> PINCodeViewNavigatorType
}

extension PINCodeViewAssembler {
    func resolve(state: PINCodeState, navigationController: UINavigationController) -> PINCodeView {
        return PINCodeView(viewModel: resolve(state: state, navigationController: navigationController))
    }
    func resolve(state: PINCodeState, navigationController: UINavigationController) -> PINCodeViewModel {
        return PINCodeViewModel(state: state, navigator: resolve(navigationController: navigationController))
    }
}

extension PINCodeViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> PINCodeViewNavigatorType {
        return PINCodeViewNavigator(assembler: self, navigationController: navigationController)
    }
}

extension PINCodeViewAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> PINCodeViewNavigatorType {
        return PINCodeViewNavigator(assembler: self, navigationController: navigationController)
    }
}
