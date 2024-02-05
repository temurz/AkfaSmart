//
//  Login+API.swift
//  AkfaSmart
//
//  Created by Temur on 28/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Alamofire
import Foundation
extension API {
    func login(_ input: LoginInput) -> Observable<ResponseModel<LoginOutput>> {
        return request(input)
    }
    
    final class LoginInput: APIInput {
        init(dto: LoginDto) {
            let params: Parameters = [
                "username": dto.username ?? "",
                "password": dto.password ?? ""
            ]
            
            
            super.init(urlString: API.Urls.login,
                       parameters: params,
                       method: .post,
                       requireAccessToken: false)
        }
    }
    
    final class LoginOutput: Decodable {
        private(set) var username: String?
        private(set) var remoteSession: String?
        
        // swiftlint:disable:next nesting
        private enum CodingKeys: String, CodingKey {
            case username, remoteSession
        }
    }
}
