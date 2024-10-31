//
//  EditCardViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 31/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol EditCardViewUseCaseType {
    func block(id: Int) -> Observable<Bool>
    func unblock(id: Int, connectedPhone: String) -> Observable<Bool>
}

struct EditCardViewUseCase: EditCardViewUseCaseType, EditCardStateDomainUseCase {
    var gateway: EditCardStateGatewayType
}

protocol ChangeCardSettingsUseCaseType {
    func changeCardSettings(_ card: Card) -> Observable<Bool>
}

struct ChangeCardSettingsUseCase: ChangeCardSettingsUseCaseType, AddCardDomainUseCase {
    var gateway: AddCardGatewayType
}
