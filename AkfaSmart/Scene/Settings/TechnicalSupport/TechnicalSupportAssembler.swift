//
//  TechnicalSupportAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 18/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol TechnicalSupportAssembler {
    func resolve(navigationController: UINavigationController) -> TechnicalSupportView
    func resolve(navigationController: UINavigationController) -> TechnicalSupportViewModel
    func resolve() -> TechnicalSupportUseCaseType
}

extension TechnicalSupportAssembler {
    func resolve(navigationController: UINavigationController) -> TechnicalSupportView {
        return TechnicalSupportView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> TechnicalSupportViewModel {
        return TechnicalSupportViewModel(useCase: resolve(), navigator: PopViewNavigator(navigationController: navigationController))
    }
}

extension TechnicalSupportAssembler where Self: DefaultAssembler {
    func resolve() -> TechnicalSupportUseCaseType {
        return TechnicalSupportUseCase(gateway: MessagesGateway())
    }
}

extension TechnicalSupportAssembler where Self: PreviewAssembler {
    func resolve() -> TechnicalSupportUseCaseType {
        return TechnicalSupportUseCase(gateway: MessagesGateway())
    }
}
