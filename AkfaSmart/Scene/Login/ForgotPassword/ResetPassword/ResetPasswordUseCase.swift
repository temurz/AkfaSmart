//
//  ResetPasswordUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 21/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ResetPasswordUseCaseType {
    func resetPassword(newPassword: String) -> Observable<Bool>
}

struct ResetPasswordUseCase: ResetPasswordUseCaseType, ResetPasswordDomainUseCase {
    let resetPasswordGateway: ResetPasswordGatewayType
}
