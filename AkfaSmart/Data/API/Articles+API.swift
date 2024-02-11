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
        init(dto: GetPageDto) {
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
                "filter":
                    [
                        "additionalProp1" : "string",
                        "additionalProp2" : "string",
                        "additionalProp3" : "string"
                    ]
            ]
            super.init(urlString: API.Urls.getArticles, parameters: parameters, method: .post,encoding: JSONEncoding.prettyPrinted, requireAccessToken: true)
        }
    }
    
    struct GetArticlesOutput: Decodable {
        var total: Int
        var rows: [ArticleItemViewModel]
    }
}
