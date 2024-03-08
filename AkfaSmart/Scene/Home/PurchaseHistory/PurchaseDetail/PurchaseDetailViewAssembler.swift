//
//  PurchaseDetailViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol PurchaseDetailViewAssembler {
    func resolve(model: Invoice) -> PurchaseDetailView
    func resolve() -> PurchaseDetailViewModel
    func resolve() -> PurchaseDetailViewUseCaseType
}

extension PurchaseDetailViewAssembler {
    func resolve(model: Invoice) -> PurchaseDetailView {
        return PurchaseDetailView(model: model, viewModel: resolve())
    }
    
    func resolve() -> PurchaseDetailViewModel {
        return PurchaseDetailViewModel(useCase: resolve())
    }
}

extension PurchaseDetailViewAssembler where Self: DefaultAssembler {
    func resolve() -> PurchaseDetailViewUseCaseType {
        return PurchaseDetailViewUseCase(gateway: resolve())
    }
}

extension PurchaseDetailViewAssembler where Self: PreviewAssembler {
    func resolve() -> PurchaseDetailViewUseCaseType {
        return PurchaseDetailViewUseCase(gateway: resolve())
    }
}
