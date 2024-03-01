//
//  AddDealerAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol AddDealerAssembler {
    func resolve(navigationController: UINavigationController) -> AddDealerView
    func resolve(navigationController: UINavigationController) -> AddDealerViewModel
    func resolve(navigationController: UINavigationController) -> AddDealerNavigatorType
    func resolve() -> AddDealerUseCaseType
}

extension AddDealerAssembler {
    func resolve(navigationController: UINavigationController) -> AddDealerView {
        return AddDealerView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> AddDealerViewModel {
        return AddDealerViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve())
    }
}

extension AddDealerAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> AddDealerNavigatorType {
        return AddDealerNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> AddDealerUseCaseType {
        return AddDealerUseCase(gateway: resolve())
    }
}

extension AddDealerAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> AddDealerNavigatorType {
        return AddDealerNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> AddDealerUseCaseType {
        return AddDealerUseCase(gateway: resolve())
    }
}
