//
//  DeleteCardDomainUseCAse.swift
//  AkfaSmart
//
//  Created by Temur on 30/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol DeleteCardDomainUseCase {
    var gateway: DeleteCardGatewayType { get }
}

extension DeleteCardDomainUseCase {
    func deleteCard(id: Int) -> Observable<Bool> {
        gateway.deleteCard(id: id)
    }
}
