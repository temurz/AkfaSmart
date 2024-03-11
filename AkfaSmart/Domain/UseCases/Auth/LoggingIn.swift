//
//  LoggingIn.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/29/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Combine
import Foundation
import ValidatedPropertyKit
import Dto

struct LoginDto: Dto {
    @Validated(.nonEmpty(message: "PLEASE_ENTER_USERNAME".localizedString) && .validPhoneNumber())
    var username: String?

    @Validated(.nonEmpty(message: "PLEASE_ENTER_PASSWORD".localizedString) && .minimumCharacters(5))
    var password: String?
    
    var validatedProperties: [ValidatedProperty] {
        return [_username, _password]
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    init() { }
    
    static func validateUserName(_ username: String) -> Result<String, ValidationError> {
        LoginDto()._username.isValid(value: username)
    }
    
    static func validatePassword(_ password: String) -> Result<String, ValidationError> {
        LoginDto()._password.isValid(value: password)
    }
}

protocol LoggingIn {
    var authGateway: AuthGatewayType { get }
}

extension LoggingIn {
    func login(dto: LoginDto) -> Observable<Bool> {
        if let error = dto.validationError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return authGateway.login(dto: dto)
    }
}

