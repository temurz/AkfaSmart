//
//  Message+API.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 11/03/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation

extension API {
    
    func getMessages(_ input:GetMessagesAPIInput) -> Observable <[MessageModel]> {
        requestList(input)
    }
    
    final class GetMessagesAPIInput: APIInput {
        init (dto:GetPageDto) {
            
            let parametres: [String : Any] = [
              "start": 0,
              "length": 10,
              "order": [
                [
                  "field": "string",
                  "sort": "string"
                ]
              ],
              "filter": [
                "additionalProp1": "string",
                "additionalProp2": "string",
                "additionalProp3": "string"
              ]
           ]
            super.init(urlString: API.Urls.getMessages, parameters: parametres, method: .post, requireAccessToken: true)
        }
    }
}
