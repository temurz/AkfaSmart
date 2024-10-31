//
//  CodeInputUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation

//MARK: ConfirmRegister
protocol CodeInputUseCaseType {
    func confirmRegister(dto: CodeInputDto) -> Observable<Bool>
}

struct CodeInputUseCase: CodeInputUseCaseType, CodeInputConfirmType {
    let codeInputGateway: CodeInputGatewayType
}

//MARK: ResendSMS
protocol ResendSMSUseCaseType {
    func resendSMS(reason: CodeReason) -> Observable<Bool>
}

struct ResendSMSUseCase: ResendSMSUseCaseType, ResendSMSDomainUseCaseType {
    let resendSMSGateway: ResendSMSGatewayType
}


//MARK: ConfirmForgotPassword
protocol ConfirmSMSCodeOnForgotPasswordUseCaseType {
    func confirmSMSCodeOnForgotPassword(dto: CodeInputDto) -> Observable<Bool>
}

struct ConfirmSMSCodeOnForgotPasswordUseCase: ConfirmSMSCodeOnForgotPasswordUseCaseType, ConfirmSMSCodeOnForgotPasswordDomainUseCase {
    let confirmSMSCodeOnForgotPasswordGateway: ConfirmSMSCodeOnForgotPasswordGatewayType
}

protocol CardConfirmActionUseCaseType {
    func confirmBlockAction(id: Int, confirmationCode: String) -> Observable<Bool>
    func confirmUnblockAction(id: Int, confirmationCode: String) -> Observable<Bool>
}

struct CardConfirmActionUseCase: CardConfirmActionUseCaseType, ConfirmCardActionDomainUseCase {
    var gateway: CardConfirmActionGatewayType
}
