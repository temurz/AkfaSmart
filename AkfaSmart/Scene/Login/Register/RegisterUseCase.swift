//
//  RegisterUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 27/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol RegisterUseCaseType {
    func register(dto: RegisterDto) -> Observable<Bool>
}
struct RegisterUseCase: RegisterUseCaseType, RegisterAuth {
    var registerGateway: RegisterGatewayType
}
