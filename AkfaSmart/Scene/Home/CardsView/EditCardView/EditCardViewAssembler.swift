//
//  EditCardViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 31/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol EditCardViewAssembler {
    func resolve(model: Card, navigationController: UINavigationController) -> EditCardView
    func resolve(model: Card, navigationController: UINavigationController) -> EditCardViewModel
    func resolve(navigationController: UINavigationController) -> EditCardViewNavigatorType
    func resolve() -> EditCardViewUseCaseType
    func resolve() -> ChangeCardSettingsUseCaseType
}

extension EditCardViewAssembler {
    func resolve(model: Card, navigationController: UINavigationController) -> EditCardView {
        return EditCardView(viewModel: resolve(model: model, navigationController: navigationController))
    }
    func resolve(model: Card, navigationController: UINavigationController) -> EditCardViewModel {
        return EditCardViewModel(
            model: model,
            editCardUseCase: resolve(),
            settingCardUseCase: resolve(),
            deleteCardUseCase: DeleteCardUseCase(gateway: DeleteCardGateway()),
            getCardUseCase: GetCardsViewUseCase(gateway: GetCardsGateway()),
            navigator: resolve(navigationController: navigationController))
    }
}

extension EditCardViewAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> EditCardViewNavigatorType {
        return EditCardViewNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> EditCardViewUseCaseType {
        return EditCardViewUseCase(gateway: resolve())
    }
    
    func resolve() -> ChangeCardSettingsUseCaseType {
        return ChangeCardSettingsUseCase(gateway: resolve())
    }

}

extension EditCardViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> EditCardViewNavigatorType {
        return EditCardViewNavigator(assembler: self, navigationController: navigationController)
    }
    func resolve() -> EditCardViewUseCaseType {
        return EditCardViewUseCase(gateway: resolve())
    }
    
    func resolve() -> ChangeCardSettingsUseCaseType {
        return ChangeCardSettingsUseCase(gateway: resolve())
    }
}
