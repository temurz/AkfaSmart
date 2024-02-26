//
//  ForgotPasswordDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 18/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import ValidatedPropertyKit
import Dto
struct PhoneNumberDTO: Dto {
    @Validated(.nonEmpty(message: "Phone number cannot be empty") && .validPhoneNumber())
    var phoneNumber: String?
    
    var validatedProperties: [ValidatedProperty] {
        return [_phoneNumber]
    }
    
    init(phoneNumber: String?) {
        self.phoneNumber = phoneNumber
    }
    
    init() { }
    
    static func validatePhoneNumber(_ phoneNumber: String) -> Result<String, ValidationError> {
        PhoneNumberDTO()._phoneNumber.isValid(value: phoneNumber)
    }
}

protocol ForgotPasswordDomainUseCase {
    var forgotPasswordGateway: ForgotPasswordGatewayType { get }
}

extension ForgotPasswordDomainUseCase {
    func requestSMSOnForgotPassword(phoneNumber: String) -> Observable<Bool> {
        return forgotPasswordGateway.requestSMSOnForgotPassword(phoneNumber: phoneNumber)
    }
}

protocol ConfirmSMSCodeOnForgotPasswordDomainUseCase {
    var confirmSMSCodeOnForgotPasswordGateway: ConfirmSMSCodeOnForgotPasswordGatewayType { get }
}

extension ConfirmSMSCodeOnForgotPasswordDomainUseCase {
    func confirmSMSCodeOnForgotPassword(dto: CodeInputDto) -> Observable<Bool> {
        return confirmSMSCodeOnForgotPasswordGateway.confirmSMSCodeOnForgotPassword(dto: dto)
    }
}



//MARK: - ResetPassword

protocol ResetPasswordDomainUseCase {
    var resetPasswordGateway: ResetPasswordGatewayType { get }
}

extension ResetPasswordDomainUseCase {
    func resetPassword(newPassword: String) -> Observable<Bool> {
        return resetPasswordGateway.resetPassword(newPassword: newPassword)
    }
}
