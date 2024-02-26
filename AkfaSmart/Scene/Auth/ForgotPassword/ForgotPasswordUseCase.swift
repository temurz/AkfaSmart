//
//  ForgotPasswordUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 18/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ForgotPasswordUseCaseType {
    func requestSMSOnForgotPassword(phoneNumber: String) -> Observable<Bool>
}

struct ForgotPasswordUseCase: ForgotPasswordUseCaseType, ForgotPasswordDomainUseCase {
    var forgotPasswordGateway: ForgotPasswordGatewayType
}
