//
//  CodeInputUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol CodeInputUseCaseType {
    func confirmRegister(dto: CodeInputDto) -> Observable<Bool>
}

struct CodeInputUseCase: CodeInputUseCaseType, CodeInputConfirmType {
    let codeInputGateway: CodeInputGatewayType
}
