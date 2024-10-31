//
//  CodeInputGateway.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import Combine
protocol CodeInputGatewayType {
    func confirmRegister(dto: CodeInputDto) -> Observable<Bool>
}

struct CodeInputGateway: CodeInputGatewayType {
    func confirmRegister(dto: CodeInputDto) -> Observable<Bool> {
        if !dto.isValid {
            return Empty().eraseToAnyPublisher()
        }
       
        let input = API.CodeConfirmInput(dto: dto)
        return API.shared.confirmRegister(input)
            .tryMap { output in
                guard let remoteSession = output.remoteSession else {
                    return false
                }
                AuthApp.shared.token = remoteSession
                AuthApp.shared.username = output.username
                
                return true
            }
            .eraseToAnyPublisher()
    }
}

protocol ConfirmSMSCodeOnForgotPasswordGatewayType {
    func confirmSMSCodeOnForgotPassword(dto: CodeInputDto) -> Observable<Bool>
}

struct ConfirmSMSCodeOnForgotPasswordGateway: ConfirmSMSCodeOnForgotPasswordGatewayType {
    func confirmSMSCodeOnForgotPassword(dto: CodeInputDto) -> Observable<Bool> {
        if !dto.isValid {
            return Empty().eraseToAnyPublisher()
        }
        
        let input = API.ConfirmSMSCodeOnForgotPasswordInput(dto: dto)
        return API.shared.confirmSMSCodeOnForgotPassword(input: input)
            .tryMap({ bool in
                if bool {
                    AuthApp.shared.smsCode = dto.code
                }
                return bool
            })
            .eraseToAnyPublisher()
    }
}

protocol CardActivationGatewayType {
    func activateCard(_ cardNumber: String, confirmationCode: String) -> Observable<Bool>
}

struct CardActivationGateway: CardActivationGatewayType {
    func activateCard(_ cardNumber: String, confirmationCode: String) -> Observable<Bool> {
        return API.shared.activateCard(API.ActivateCardInput(cardNumber: cardNumber, confirmationCode: confirmationCode))
    }
}

protocol CardConfirmActionGatewayType {
    func confirmBlockAction(id: Int, confirmationCode: String) -> Observable<Bool>
    func confirmUnblockAction(id: Int, confirmationCode: String) -> Observable<Bool>
}

struct CardConfirmActionGateway: CardConfirmActionGatewayType {
    func confirmBlockAction(id: Int, confirmationCode: String) -> Observable<Bool> {
        return API.shared.confirmCardAction(API.ConfirmCardActionInput(action: "block", id: id, confirmationCode: confirmationCode))
    }
    
    func confirmUnblockAction(id: Int, confirmationCode: String) -> Observable<Bool> {
        return API.shared.confirmCardAction(API.ConfirmCardActionInput(action: "unblock", id: id, confirmationCode: confirmationCode))
    }
}
