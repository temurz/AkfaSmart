//
//  GetCardsViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 26/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol GetCardsViewUseCaseType {
    func getCards(_ cardNumber: String?) -> Observable<[Card]>
}

struct GetCardsViewUseCase: GetCardsViewUseCaseType, GetCardsDomainUseCase {
    var gateway: GetCardsGatewayType
}
