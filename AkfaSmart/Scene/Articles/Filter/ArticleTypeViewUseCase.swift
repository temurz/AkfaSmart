//
//  ArticleTypeViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 07/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ArticleTypeViewUseCaseType {
    func getArticleTypes() -> Observable<[ArticleType]>
}

struct ArticleTypeViewUseCase: ArticleTypeViewUseCaseType, GettingArticleTypeDomainUseCase {
    var gateway: ArticleTypeGatewayType
}
