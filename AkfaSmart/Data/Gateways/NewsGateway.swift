//
//  NewsGateway.swift
//  AkfaSmart
//
//  Created by Temur on 10/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol NewsGatewayType {
    func getNews(dto: GetPageDto) -> Observable<PagingInfo<NewsItemViewModel>>
}

struct NewsGateway: NewsGatewayType {
    func getNews(dto: GetPageDto) -> Observable<PagingInfo<NewsItemViewModel>> {
        let input = API.GetNewsInput(start: dto.page)
        return API.shared.getNews(input)
            .tryMap { output in
                return output.rows
            }
            .replaceNil(with: [])
            .map { PagingInfo(page: dto.page, items: $0) }
            .eraseToAnyPublisher()
            .eraseToAnyPublisher()
    }
}
