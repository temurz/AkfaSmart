//
//  News+API.swift
//  AkfaSmart
//
//  Created by Temur on 10/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Alamofire
import UIKit
extension API {
    func getNews(_ input: GetNewsInput) -> Observable<GetNewsOutput> {
        return request(input)
    }
    
    final class GetNewsInput: APIInput {
        init(start: Int) {
            let params: [String: Any] = [
                "start": 1,
                "length": 10,
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
            
            super.init(urlString: API.Urls.getNews, parameters: params, method: .post, encoding: JSONEncoding.prettyPrinted, requireAccessToken: true)
        }
    }
    
    final class GetNewsOutput: Decodable {
        let total: Int
        let rows: [NewsItemViewModel]
    }
}
