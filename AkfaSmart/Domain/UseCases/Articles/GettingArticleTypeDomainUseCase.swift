//
//  GettingArticleTypeDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 07/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol GettingArticleTypeDomainUseCase {
    var gateway: ArticleTypeGatewayType { get  }
}

extension GettingArticleTypeDomainUseCase {
    func getArticleTypes() -> Observable<[ArticleType]> {
        gateway.getArticleTypes()
    }
}
