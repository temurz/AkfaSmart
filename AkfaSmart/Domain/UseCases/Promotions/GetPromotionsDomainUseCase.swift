//
//  GetPromotionsDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 12/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

protocol GetPromotionsDomainUseCase {
    var gateway: GetPromotionsGatewayProtocol { get }
}

extension GetPromotionsDomainUseCase {
    func getPromotionsList() -> Observable<[Promotion]> {
        gateway.getPromotionsList()
    }
}
