//
//  ResendSMS+API.swift
//  AkfaSmart
//
//  Created by Temur on 20/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Alamofire
extension API {
    func resendSMS(_ input: ResendSMSInput) -> Observable<Bool> {
        success(input)
    }
    
    final class ResendSMSInput: APIInput {
        init(reason: CodeReason) {
            
            let url = reason == .register ? API.Urls.resendRegisterCode : API.Urls.resendForgotPassword
            let username = AuthApp.shared.username ?? ""
            let params: Parameters = [
                "username": username
            ]
            
            super.init(urlString: url, parameters: params, method: .post, requireAccessToken: false)
        }
    }
}
