//
//  EditCardStateDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 31/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol EditCardStateDomainUseCase {
    var gateway: EditCardStateGatewayType { get }
}

extension EditCardStateDomainUseCase {
    func block(id: Int) -> Observable<Bool> {
        gateway.block(id: id)
    }
    
    func unblock(id: Int, connectedPhone: String) -> Observable<Bool> {
        gateway.unblock(id: id, connectedPhone: connectedPhone)
    }

}

 
