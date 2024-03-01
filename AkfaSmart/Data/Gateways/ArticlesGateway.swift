//
//  ArticlesGateway.swift
//  AkfaSmart
//
//  Created by Temur on 11/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ArticlesGatewayType {
    func getArticles(dto: GetPageDto) -> Observable<PagingInfo<ArticleItemViewModel>>
}

struct ArticlesGateway: ArticlesGatewayType {
    func getArticles(dto: GetPageDto) -> Observable<PagingInfo<ArticleItemViewModel>> {
        let input = API.GetArticlesInput(dto: dto)
        return API.shared.getArticles(input)
            .tryMap { output in
                return output.rows
            }
            .replaceNil(with: [])
            .map { PagingInfo(page: dto.page, items: $0, hasMorePages: $0.count == dto.perPage) }
            .eraseToAnyPublisher()
    }
}


