//
//  CodeInputAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol CodeInputAssembler {
    func resolve(navigationController: UINavigationController, title: String) -> CodeInputView
    func resolve(navigationController: UINavigationController, title: String) -> CodeInputViewModel
    func resolve(navigationController: UINavigationController) -> CodeInputNavigatorType
    func resolve() -> CodeInputUseCaseType

}

extension CodeInputAssembler {
    func resolve(navigationController: UINavigationController, title: String) -> CodeInputView {
        return CodeInputView(viewModel: resolve(navigationController: navigationController, title: title))
    }
    
    func resolve(navigationController: UINavigationController, title: String) -> CodeInputViewModel {
        return CodeInputViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            title: title)
    }
}

extension CodeInputAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CodeInputNavigatorType {
        return CodeInputNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> CodeInputUseCaseType {
        return CodeInputUseCase(codeInputGateway: resolve())
    }
}

extension CodeInputAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> CodeInputNavigatorType {
        return CodeInputNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> CodeInputUseCaseType {
        return CodeInputUseCase(codeInputGateway: resolve())
    }
}
