//
//  TechnoGraphicsGateway.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol TechnoGraphicsGatewayType {
    func getTechnoGraphics() -> Observable<TechnoGraphics>
}

struct TechnoGraphicsGateway: TechnoGraphicsGatewayType {
    func getTechnoGraphics() -> Observable<TechnoGraphics> {
        let input = API.TechnoGraphicsInput()
        return API.shared.getTechnoGraphics(input)
    }
}
