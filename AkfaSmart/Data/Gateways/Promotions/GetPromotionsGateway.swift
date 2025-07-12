//
//  GetPromotionsGateway.swift
//  AkfaSmart
//
//  Created by Temur on 12/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

protocol GetPromotionsGatewayProtocol {
    func getPromotionsList() -> Observable<[Promotion]>
}

struct GetPromotionsGateway: GetPromotionsGatewayProtocol {
    func getPromotionsList() -> Observable<[Promotion]> {
        let input = API.GetPromotionListAPIInput()
        return API.shared.getPromotionsList(input)
    }
}
