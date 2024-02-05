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
                if let body = output.body {
                    AuthApp.shared.token = body.remoteSession
                    AuthApp.shared.username = body.username
                }
                
                return output.body?.remoteSession != nil ? true : false
            }
            .eraseToAnyPublisher()
    }
}
