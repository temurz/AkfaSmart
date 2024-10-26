//
//  GetCardsDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 26/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol GetCardsDomainUseCase {
    var gateway: GetCardsGatewayType { get }
}

extension GetCardsDomainUseCase {
    func getCards(_ cardNumber: String?) -> Observable<[Card]> {
        gateway.getCards(cardNumber: cardNumber)
    }
}
