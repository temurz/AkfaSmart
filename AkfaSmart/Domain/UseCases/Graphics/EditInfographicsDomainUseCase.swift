//
//  EditInfographicsDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 12/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol EditInfographicsDomainUseCase {
    var gateway: EditInfographicsGatewayType { get }
}

extension EditInfographicsDomainUseCase {
    func editInfographics(infographics: Infographics) -> Observable<Bool> {
        gateway.editInfographics(infographics: infographics)
    }
    
    func loadRegions(parentId: Int?) -> Observable<[Region]> {
        gateway.loadRegions(parentId: parentId)
    }
    
    func getLanguages() -> Observable<[ModelWithIdAndName]> {
        gateway.getLanguages()
    }
}
