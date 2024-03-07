//
//  ArticlesUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ArticlesUseCaseType {
    func getArticles(input: ArticlesGetInput, page: Int) -> Observable<PagingInfo<ArticleItemViewModel>>
}

struct ArticlesUseCase: ArticlesUseCaseType, ArticlesDomainUseCaseType {
    let articlesGateway: ArticlesGatewayType
    
    func getArticles(input: ArticlesGetInput, page: Int) -> Observable<PagingInfo<ArticleItemViewModel>> {
        let dto = GetPageDto(page: page)
        return getArticles(input: input, dto: dto)
    }
}
