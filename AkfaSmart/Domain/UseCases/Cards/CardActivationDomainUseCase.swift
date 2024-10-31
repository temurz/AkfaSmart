//
//  CardActivationDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 30/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol CardActivationDomainUseCase {
    var gateway: CardActivationGatewayType { get }
}

extension CardActivationDomainUseCase {
    func activateCard(_ cardNumber: String, confirmationCode: String) -> Observable<Bool> {
        gateway.activateCard(cardNumber, confirmationCode: confirmationCode)
    }
}
