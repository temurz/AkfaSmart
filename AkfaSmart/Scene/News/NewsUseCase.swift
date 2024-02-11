//
//  NewsUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol NewsUseCaseType {
    func getNews(page: Int) -> Observable<PagingInfo<NewsItemViewModel>>
}

struct NewsUseCase: NewsUseCaseType, NewsDomainUseCaseType {
    let newsGateway: NewsGatewayType
    
    func getNews(page: Int) -> Observable<PagingInfo<NewsItemViewModel>> {
        let dto = GetPageDto(page: page)
        return getNews(dto: dto)
    }
}
