//
//  HRGraphicsEditGateway.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol HRGraphicsEditGatewayType {
    func editHRGraphics(_ model: HRGraphics) -> Observable<Bool>
}

struct HRGraphicsEditGateway: HRGraphicsEditGatewayType {
    func editHRGraphics(_ model: HRGraphics) -> Observable<Bool> {
        let input = API.EditHRGraphics(model)
        return API.shared.editHRGraphics(input)
    }
    
    
}
