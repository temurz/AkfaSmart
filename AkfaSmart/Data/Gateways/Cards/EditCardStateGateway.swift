//
//  EditCardStateGateway.swift
//  AkfaSmart
//
//  Created by Temur on 31/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol EditCardStateGatewayType {
    func block(id: Int) -> Observable<Bool>
    func unblock(id: Int, connectedPhone: String) -> Observable<Bool>
}

struct EditCardStateGateway: EditCardStateGatewayType {
    func block(id: Int) -> Observable<Bool> {
        API.shared.blockCard(API.BlockCardInput(id: id))
    }
    
    func unblock(id: Int, connectedPhone: String) -> Observable<Bool> {
        API.shared.unblockCard(API.UnblockCardInput(id: id, connectedPhone: connectedPhone))
    }
}
