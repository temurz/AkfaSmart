//
//  ArticleDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 11/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ArticlesDomainUseCaseType {
    var articlesGateway: ArticlesGatewayType { get }
}

extension ArticlesDomainUseCaseType {
    func getArticles(input: ArticlesGetInput, dto: GetPageDto) -> Observable<PagingInfo<ArticleItemViewModel>> {
        return articlesGateway.getArticles(input: input, dto: dto)
    }
}
