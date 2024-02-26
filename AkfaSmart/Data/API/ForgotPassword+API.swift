//
//  ForgotPassword+API.swift
//  AkfaSmart
//
//  Created by Temur on 18/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Alamofire
extension API {
    func requestSMSCodeOnForgotPassword(input: ForgotPasswordInput) -> Observable<Bool> {
        success(input)
    }
    
    final class ForgotPasswordInput: APIInput {
        init(phoneNumber: String) {
            let params: Parameters = [
                "username": phoneNumber
            ]
            super.init(urlString: API.Urls.requestSMSCodeOnForgotPassword, parameters: params, method: .post, requireAccessToken: false)
        }
    }
}

extension API {
    func resetPassword(input: ResetPasswordInput) -> Observable<Bool> {
        success(input)
    }
    
    final class ResetPasswordInput: APIInput {
        init(newPassword: String) {
            let username = AuthApp.shared.username ?? ""
            let resetCode = AuthApp.shared.smsCode ?? ""
            let params: Parameters = [
                "username": username,
                "resetCode": resetCode,
                "newPassword": newPassword
            ]
            super.init(urlString: API.Urls.resetPassword, parameters: params, method: .post, requireAccessToken: false)
        }
    }
}
