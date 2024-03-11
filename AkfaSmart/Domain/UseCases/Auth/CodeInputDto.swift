//
//  CodeInput.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Combine
import Foundation
import ValidatedPropertyKit
import Dto
struct CodeInputDto: Dto {
    
    @Validated(.nonEmpty(message: "CODE_CANNOT_BE_EMPTY".localizedString))
    var code: String?
    
    var validatedProperties: [ValidatedProperty] {
        return [_code]
    }
    
    init(code: String?) {
        self.code = code
    }
    
    init() {}
    
    static func validateCode(_ code: String) -> Result<String, ValidationError> {
        CodeInputDto()._code.isValid(value: code)
    }
}

protocol CodeInputConfirmType {
    var codeInputGateway: CodeInputGatewayType { get }
}

extension CodeInputConfirmType {
    func confirmRegister(dto: CodeInputDto) -> Observable<Bool> {
        if let error = dto.validationError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return codeInputGateway.confirmRegister(dto: dto)
    }
}


