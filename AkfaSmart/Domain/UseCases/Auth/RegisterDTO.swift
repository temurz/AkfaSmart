//
//  RegisterDTO.swift
//  AkfaSmart
//
//  Created by Temur on 27/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Combine
import Foundation
import ValidatedPropertyKit
import Dto

struct RegisterDto: Dto {
    @Validated(.nonEmpty(message: "PLEASE_ENTER_USERNAME".localizedString) && .validPhoneNumber())
    var username: String?

    @Validated(.nonEmpty(message: "PLEASE_ENTER_PASSWORD".localizedString) && .minimumCharacters(6))
    var password: String?
    
    @Validated(.nonEmpty(message: "PLEASE_ENTER_PASSWORD".localizedString))
    var repeatedPassword: String?
    
    var validatedProperties: [ValidatedProperty] {
        return [_username, _password, _repeatedPassword]
    }
    
    init(username: String, password: String, repeatedPassword: String) {
        self.username = username
        self.password = password
        self.repeatedPassword = repeatedPassword
    }
    
    init() { }
    
    static func validateUserName(_ username: String) -> Result<String, ValidationError> {
        RegisterDto()._username.isValid(value: username)
    }
    
    static func validatePassword(_ password: String) -> Result<String, ValidationError> {
        RegisterDto()._password.isValid(value: password)
    }
    
    static func validateRepeatedPassword(_ repeatedPassword: String) -> Result<String, ValidationError> {
        RegisterDto()._repeatedPassword.isValid(value: repeatedPassword)
    }
}

protocol RegisterAuth {
    var registerGateway: RegisterGatewayType { get }
}

extension RegisterAuth {
    func register(dto: RegisterDto) -> Observable<Bool> {
        if let error = dto.validationError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return registerGateway.register(dto: dto)
    }
}
