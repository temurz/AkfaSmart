//
//  ClassDetailViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol ClassDetailViewAssembler {
    func resolve(imageData: Data?, title: String?, navigationController: UINavigationController) -> UserClassDetailView
    func resolve(navigationController: UINavigationController) -> ClassDetailViewModel
    func resolve() -> ClassDetailViewUseCaseType
}

extension ClassDetailViewAssembler {
    func resolve(imageData: Data?, title: String?, navigationController: UINavigationController) -> UserClassDetailView {
        return UserClassDetailView(viewModel: resolve(navigationController: navigationController), imageData, title: title)
    }
    
    func resolve(navigationController: UINavigationController) -> ClassDetailViewModel {
        return ClassDetailViewModel(useCase: resolve(), navigator: PopViewNavigator(navigationController: navigationController))
    }
}

extension ClassDetailViewAssembler where Self: DefaultAssembler {
    func resolve() -> ClassDetailViewUseCaseType {
        return ClassDetailViewUseCase(gateway: resolve())
    }
}

extension ClassDetailViewAssembler where Self: PreviewAssembler {
    func resolve() -> ClassDetailViewUseCaseType {
        return ClassDetailViewUseCase(gateway: resolve())
    }
}
