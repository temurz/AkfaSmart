//
//  NewsDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 10/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol NewsDomainUseCase {
    var newsGateway: NewsGatewayType { get }
}

extension NewsDomainUseCase {
    func getNews(dto: GetPageDto) -> Observable<PagingInfo<NewsItemViewModel>> {
        return newsGateway.getNews(dto: dto)
    }
}
