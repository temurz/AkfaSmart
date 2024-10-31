//
//  EditInfographicsGateway.swift
//  AkfaSmart
//
//  Created by Temur on 12/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol EditInfographicsGatewayType {
    func editInfographics(infographics: Infographics) -> Observable<Bool>
    func loadRegions(parentId: Int?) -> Observable<[Region]>
    func getLanguages() -> Observable<[ModelWithIdAndName]>
}

struct EditInfographicsGateway: EditInfographicsGatewayType {
    func editInfographics(infographics: Infographics) -> Observable<Bool> {
        let input = API.EditInfoGraphicsAPIInput(graphics: infographics)
        return API.shared.editInfographics(input)
    }
    
    func loadRegions(parentId: Int?) -> Observable<[Region]> {
        let input = API.GetRegionsAPIInput(parentId: parentId)
        return API.shared.getRegions(input)
    }
    
    func getLanguages() -> Observable<[ModelWithIdAndName]> {
        let input = API.GetLanguagesAPIInput()
        return API.shared.getLanguages(input)
    }
}
