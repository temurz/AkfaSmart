//
//  Articles+API.swift
//  AkfaSmart
//
//  Created by Temur on 11/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Alamofire
extension API {
    func getArticles(_ input: API.GetArticlesInput) -> Observable<GetArticlesOutput> {
        return request(input)
    }
    
    final class GetArticlesInput: APIInput {
        init(input: ArticlesGetInput, dto: GetPageDto) {
            
            var filter: [String: Any] = [:]
            var typeKey = "additionalProp1"
            var fromKey = "additionalProp2"
            var toKey = "additionalProp3"
            
            if let type = input.type {
                typeKey = "typeId"
                filter[typeKey] = type
            }else {
                filter[typeKey] = ""
            }
            if let from = input.from {
                fromKey = "fromDate"
                filter[fromKey] = from.toShortFormat()
            }else {
                filter[fromKey] = ""
            }
            if let to = input.to {
                toKey = "toDate"
                filter[toKey] = to.toShortFormat()
            }else {
                filter[toKey] = ""
            }
            if let title = input.name {
                filter["title"] = title
            }
            
            let parameters: [String: Any] = [
                "start": dto.page,
                "length": dto.perPage,
                "order":
                    [
                        [
                            "field": "string",
                            "sort": "string"
                        ]
                    ],
                "filter": filter
                
            ]
            
            super.init(urlString: API.Urls.getArticles, parameters: parameters, method: .post,encoding: JSONEncoding.prettyPrinted, requireAccessToken: true)
        }
    }
    
    struct GetArticlesOutput: Decodable {
        var total: Int
        var rows: [ArticleItemViewModel]
    }
}


extension API {
    func getArticleTypes(_ input: GetArticleTypesInput) -> Observable<[ArticleType]>{
        requestList(input)
    }
    final class GetArticleTypesInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getArticleTypes, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}
