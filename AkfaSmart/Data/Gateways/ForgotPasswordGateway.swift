//
//  ForgotPasswordGateway.swift
//  AkfaSmart
//
//  Created by Temur on 18/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import Combine
protocol ForgotPasswordGatewayType {
    func requestSMSOnForgotPassword(phoneNumber: String) -> Observable<Bool>
}

struct ForgotPasswordGateway: ForgotPasswordGatewayType {
    func requestSMSOnForgotPassword(phoneNumber: String) -> Observable<Bool> {
        
        if phoneNumber.isEmpty {
            return Empty().eraseToAnyPublisher()
        }
        
        let input = API.ForgotPasswordInput(phoneNumber: phoneNumber)
        return API.shared.requestSMSCodeOnForgotPassword(input: input)
            .tryMap { bool in
                if bool {
                    AuthApp.shared.username = phoneNumber
                }
                return bool
            }
            .eraseToAnyPublisher()
    }
}


protocol ResetPasswordGatewayType {
    func resetPassword(newPassword: String) -> Observable<Bool>
}

struct ResetPasswordGateway: ResetPasswordGatewayType {
    func resetPassword(newPassword: String) -> Observable<Bool> {
        if newPassword.isEmpty {
            return Empty().eraseToAnyPublisher()
        }
        
        let input = API.ResetPasswordInput(newPassword: newPassword)
        return API.shared.resetPassword(input: input)
            .tryMap({ success in
                if success {
                    AuthApp.shared.smsCode = nil
                }
                return success
            })
            .eraseToAnyPublisher()
    }
}
