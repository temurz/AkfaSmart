//
//  AddCardViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 28/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol AddCardViewUseCaseType {
    func addCard(_ cardNumber: String) -> Observable<Bool>
    func changeCardSettings(_ card: Card) -> Observable<Bool>
}

struct AddCardViewUseCase: AddCardViewUseCaseType, AddCardDomainUseCase {
    var gateway: AddCardGatewayType
}
