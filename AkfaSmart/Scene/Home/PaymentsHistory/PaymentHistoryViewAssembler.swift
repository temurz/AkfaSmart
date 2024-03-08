//
//  PaymentHistoryViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol PaymentHistoryViewAssembler {
    func resolve(navigationController: UINavigationController) -> PaymentHistoryView
    func resolve(navigationController: UINavigationController) -> PaymentHistoryViewModel
    func resolve(navigationController: UINavigationController) -> PaymentHistoryViewNavigatorType
    func resolve() -> PaymentHistoryViewUseCaseType
}

extension PaymentHistoryViewAssembler {
    func resolve(navigationController: UINavigationController) -> PaymentHistoryView {
        return PaymentHistoryView(viewModel: resolve(navigationController: navigationController))
    }
    func resolve(navigationController: UINavigationController) -> PaymentHistoryViewModel {
        return PaymentHistoryViewModel(useCase: resolve(), navigator: resolve(navigationController: navigationController))
    }
}

extension PaymentHistoryViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> PaymentHistoryViewNavigatorType {
        return PaymentHistoryViewNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> PaymentHistoryViewUseCaseType {
        PaymentHistoryViewUseCase(gateway: resolve())
    }
}

extension PaymentHistoryViewAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> PaymentHistoryViewNavigatorType {
        return PaymentHistoryViewNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> PaymentHistoryViewUseCaseType {
        PaymentHistoryViewUseCase(gateway: resolve())
    }
}
