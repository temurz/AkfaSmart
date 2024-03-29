//
//  APIInput.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/31/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Alamofire

class APIInput: APIInputBase {  // swiftlint:disable:this final_class
    override init(urlString: String,
                  parameters: Parameters?,
                  method: HTTPMethod,
                  encoding: ParameterEncoding = URLEncoding.queryString,
                  requireAccessToken: Bool) {
        super.init(urlString: urlString,
                   parameters: parameters,
                   method: method,
                   encoding: encoding,
                   requireAccessToken: requireAccessToken)
        self.headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json"
        ]
        self.username = nil
        self.password = nil
    }
}
