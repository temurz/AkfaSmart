//
//  ArticlesFilterViewAssembler.swift
//  AkfaSmart
//
//  Created by Temur on 07/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ArticlesFilterViewAssembler {
    func resolve() -> ArticlesFilterViewModel
    func resolve() -> ArticleTypeViewUseCaseType
}

extension ArticlesFilterViewAssembler {
    func resolve() -> ArticlesFilterViewModel {
        return ArticlesFilterViewModel(useCase: resolve())
    }
}

extension ArticlesFilterViewAssembler where Self: DefaultAssembler {
    func resolve() -> ArticleTypeViewUseCaseType {
        ArticleTypeViewUseCase(gateway: resolve())
    }
}

extension ArticlesFilterViewAssembler where Self: PreviewAssembler {
    func resolve() -> ArticleTypeViewUseCaseType {
        ArticleTypeViewUseCase(gateway: resolve())
    }
}

