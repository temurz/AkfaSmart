//
//  ResendSMSDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 20/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ResendSMSDomainUseCaseType {
    var resendSMSGateway: ResendSMSGatewayType { get }
}

extension ResendSMSDomainUseCaseType {
    func resendSMS(reason: CodeReason) -> Observable<Bool> {
        return resendSMSGateway.resendSMS(reason: reason)
    }
}
