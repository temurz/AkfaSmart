//
//  ResendSMSGateway.swift
//  AkfaSmart
//
//  Created by Temur on 20/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation

protocol ResendSMSGatewayType {
    func resendSMS(reason: CodeReason) -> Observable<Bool>
}

struct ResendSMSGateway: ResendSMSGatewayType {
    func resendSMS(reason: CodeReason) -> Observable<Bool> {
        let input = API.ResendSMSInput(reason: reason)
        return API.shared.resendSMS(input)
    }
}
