//
//  GetCardsGateway.swift
//  AkfaSmart
//
//  Created by Temur on 26/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol GetCardsGatewayType {
    func getCards(cardNumber: String?) -> Observable<[Card]>
}

struct GetCardsGateway: GetCardsGatewayType {
    func getCards(cardNumber: String?) -> Observable<[Card]> {
        return API.shared.getCards(API.GetCardsInput(cardNumber: cardNumber))
    }
}
