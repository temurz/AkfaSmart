//
//  InfoGraphicsGateway.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol InfoGraphicsGatewayType {
    func getInfographics() -> Observable<Infographics>
}

struct InfoGraphicsGateway: InfoGraphicsGatewayType {
    func getInfographics() -> Observable<Infographics> {
        let input = API.InfoGraphicsInput()
        return API.shared.getInfoGraphics(input)
    }
}
