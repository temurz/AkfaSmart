//
//  DeleteCardUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 30/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol DeleteCardUseCaseType {
    func deleteCard(id: Int) -> Observable<Bool>
}

struct DeleteCardUseCase: DeleteCardUseCaseType, DeleteCardDomainUseCase {
    var gateway: DeleteCardGatewayType
}
