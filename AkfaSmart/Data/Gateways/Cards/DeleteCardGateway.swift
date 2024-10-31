//
//  DeleteCardGatewayType.swift
//  AkfaSmart
//
//  Created by Temur on 30/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol DeleteCardGatewayType {
    func deleteCard(id: Int) -> Observable<Bool>
}

struct DeleteCardGateway: DeleteCardGatewayType {
    func deleteCard(id: Int) -> Observable<Bool> {
        return API.shared.deleteCard(API.DeleteCardInput(id: id))
    }
}
