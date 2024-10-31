//
//  AddCardGateway.swift
//  AkfaSmart
//
//  Created by Temur on 30/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol AddCardGatewayType {
    func addCard(_ cardNumber: String) -> Observable<Bool>
    func changeCardSettings(_ card: Card) -> Observable<Bool>
}

struct AddCardGateway: AddCardGatewayType {
    func addCard(_ cardNumber: String) -> Observable<Bool> {
        return API.shared.addCard(API.AddCardInput(cardNumber: cardNumber))
    }
    
    func changeCardSettings(_ card: Card) -> Observable<Bool> {
        return API.shared.changeCardSettings(API.ChangeCardSettingsInput(cardCode: card.cardNumber ?? "", isMain: card.isMain ?? false, displayName: card.displayName ?? "", cardBackground: card.cardBackground ?? ""))
    }
}
