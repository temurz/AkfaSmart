//
//  ArticleTypeGateway.swift
//  AkfaSmart
//
//  Created by Temur on 07/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ArticleTypeGatewayType {
    func getArticleTypes() -> Observable<[ArticleType]>
}

struct ArticleTypeGateway: ArticleTypeGatewayType {
    func getArticleTypes() -> Observable<[ArticleType]> {
        let input = API.GetArticleTypesInput()
        return API.shared.getArticleTypes(input)
    }
}
