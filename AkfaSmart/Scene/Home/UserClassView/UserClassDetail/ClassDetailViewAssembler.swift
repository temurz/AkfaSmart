//
//  ClassDetailViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol ClassDetailViewAssembler {
    func resolve() -> UserClassDetailView
    func resolve() -> ClassDetailViewModel
    func resolve() -> ClassDetailViewUseCaseType
}

extension ClassDetailViewAssembler {
    func resolve() -> UserClassDetailView {
        return UserClassDetailView(viewModel: resolve())
    }
    
    func resolve() -> ClassDetailViewModel {
        return ClassDetailViewModel(useCase: resolve())
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
