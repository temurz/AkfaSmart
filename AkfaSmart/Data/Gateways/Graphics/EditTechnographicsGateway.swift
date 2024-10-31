//
//  EditTechnographicsGateway.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol EditTechnographicsGatewayType {
    func getSeries() -> Observable<[ModelWithIdAndName]>
    func getTools() -> Observable<[ModelWithIdAndName]>
    func save(_ model: TechnoGraphics) -> Observable<Bool>
}

struct EditTechnographicsGateway: EditTechnographicsGatewayType {
    func getSeries() -> Observable<[ModelWithIdAndName]> {
        let input = API.GetSeriesAPIInput()
        return API.shared.getSeries(input)
    }
    
    func getTools() -> Observable<[ModelWithIdAndName]> {
        let input = API.GetToolsAPIInput()
        return API.shared.getTools(input)
    }
    
    func save(_ model: TechnoGraphics) -> Observable<Bool> {
        let input = API.SaveTechnographicsAPIInput(model)
        return API.shared.saveTechnographics(input)
    }
}
