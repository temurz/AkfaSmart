//
//  ModalCodeInputViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 30/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol CardActivationUseCaseType {
    func activateCard(_ cardNumber: String, confirmationCode: String) -> Observable<Bool>
}

struct CardActivationUseCase: CardActivationUseCaseType, CardActivationDomainUseCase {
    var gateway: CardActivationGatewayType
}
