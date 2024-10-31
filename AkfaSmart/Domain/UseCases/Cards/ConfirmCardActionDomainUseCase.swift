//
//  ConfirmCardActionDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 31/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ConfirmCardActionDomainUseCase {
    var gateway: CardConfirmActionGatewayType { get }
}

extension ConfirmCardActionDomainUseCase {
    func confirmBlockAction(id: Int, confirmationCode: String) -> Observable<Bool> {
        return gateway.confirmBlockAction(id: id, confirmationCode: confirmationCode)
    }
    
    func confirmUnblockAction(id: Int, confirmationCode: String) -> Observable<Bool> {
        return gateway.confirmUnblockAction(id: id, confirmationCode: confirmationCode)
    }

}
