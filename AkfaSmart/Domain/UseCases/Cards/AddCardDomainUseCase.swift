//
//  AddCardDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 30/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol AddCardDomainUseCase {
    var gateway: AddCardGatewayType { get }
}

extension AddCardDomainUseCase {
    func addCard(_ cardNumber: String) -> Observable<Bool> {
        gateway.addCard(cardNumber)
    }
    
    func changeCardSettings(_ card: Card) -> Observable<Bool> {
        gateway.changeCardSettings(card)
    }
}
