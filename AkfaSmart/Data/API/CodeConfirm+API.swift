//
//  CodeConfirm+API.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import Alamofire
extension API {
    func confirmRegister(_ input: CodeConfirmInput) -> Observable<ResponseModel<RegistrationOutput>> {
        request(input)
    }
    
    final class CodeConfirmInput: APIInput {
        init(dto: CodeInputDto) {
            let username = AuthApp.shared.username ?? ""
            let params: Parameters = [
                "username": username,
                "activationCode": dto.code ?? ""
            ]
            
            super.init(urlString: API.Urls.confirmRegister, parameters: params, method: .post, requireAccessToken: false)
        }
    }
    
    final class RegistrationOutput: Decodable {
        private(set) var username: String?
        private(set) var remoteSession: String?
        
        private enum CodingKeys: String, CodingKey {
            case username, remoteSession
        }
    }
}
