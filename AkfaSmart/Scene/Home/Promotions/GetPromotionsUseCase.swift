//
//  GetPromotionsUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 12/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

protocol GetPromotionsUseCaseType {
    func getPromotionsList() -> Observable<[Promotion]>
}

struct GetPromotionsUseCase: GetPromotionsUseCaseType, GetPromotionsDomainUseCase {
    var gateway: GetPromotionsGatewayProtocol
}
