//
//  AuthGateway.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/29/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Combine
import Foundation
import Alamofire
protocol AuthGatewayType {
    func login(dto: LoginDto) -> Observable<Bool>
}

struct AuthGateway: AuthGatewayType {
    func login(dto: LoginDto) -> Observable<Bool> {
        if !dto.isValid {
            return Empty().eraseToAnyPublisher()
        }
       
        let input = API.LoginInput(dto: dto)
        return API.shared.login(input)
            .tryMap { output in
                let body = output.body
                
                AuthApp.shared.token = body?.remoteSession
                AuthApp.shared.username = body?.username
                return body?.remoteSession != nil ? true : false
            }
            .eraseToAnyPublisher()
    }
}
