//
//  Registration+API.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import Alamofire
extension API {
    func register(input: RegistrationInput) -> Observable<Bool> {
        return success(input)
    }
    
    final class RegistrationInput: APIInput {
        init(dto: RegisterDto) {
            let params: Parameters = [
                "username": dto.username ?? "",
                "newPassword": dto.password ?? ""
            ]
            super.init(urlString: API.Urls.register, parameters: params, method: .post, requireAccessToken: false)
        }
    }
    
    
}
