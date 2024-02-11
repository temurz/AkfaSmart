//
//  RegisterGateway.swift
//  AkfaSmart
//
//  Created by Temur on 27/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import Combine
protocol RegisterGatewayType {
    func register(dto: RegisterDto) -> Observable<Bool>
}

struct RegisterGateway: RegisterGatewayType {
    func register(dto: RegisterDto) -> Observable<Bool> {
        guard dto.isValid,
              dto.repeatedPassword == dto.password else {
            return Empty().eraseToAnyPublisher()
        }
        
        let input = API.RegistrationInput(dto: dto)
        return API.shared.register(input: input)
            .tryMap { bool in
                if bool {
                    AuthApp.shared.username = dto.username
                }
                return bool
            }
            .eraseToAnyPublisher()
    }
}
