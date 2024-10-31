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
            
            let url = 
            switch reason {
            case .register:
                API.Urls.resendRegisterCode
            case .forgotPassword:
                API.Urls.resendForgotPassword
            case .dealer:
                API.Urls.addDealer_resendSMSCode
            case .cardActivation(_):
                API.Urls.addCard
            case .block:
                API.Urls.resendCardAction + "block"
            case .unblock:
                API.Urls.resendCardAction + "unblock"
            }
            
            let username = AuthApp.shared.username ?? ""
            var params: Parameters = [
                "username": username
            ]
            var encoding: ParameterEncoding = URLEncoding.queryString
            var requireAccessToken = false
            switch reason {
            case .dealer(let dealer, let activeUsername, let isActive):
                params = [
                    "printableName": dealer.printableName ?? "",
                    "cid": dealer.cid ?? "",
                    "dealerId": dealer.dealerId ?? "",
                    "phone": dealer.phone ?? ""
                ]
                encoding = JSONEncoding.prettyPrinted
                requireAccessToken = true
            case let .block(id):
                params = [
                    "id": id
                ]
            case let .unblock(id, _):
                params = [
                    "id": id
                ]
            case let .cardActivation(cardNumber):
                params = [
                    "cardNumber": cardNumber
                ]
            default:
                break
            }
            super.init(urlString: url, parameters: params, method: .post, encoding: encoding, requireAccessToken: requireAccessToken)
        }
    }
}
