//
//  HRGateway.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol HRGatewayType {
    func getHRGraphics() -> Observable<HRGraphics>
}

struct HRGateway: HRGatewayType {
    func getHRGraphics() -> Observable<HRGraphics> {
        let input = API.HRGraphicsInput()
        return API.shared.getHRGraphics(input)
    }
}
