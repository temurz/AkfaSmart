//
//  EditInfographicsViewUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 12/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol EditInfographicsViewUseCaseType {
    func editInfographics(infographics: Infographics) -> Observable<Bool>
    func loadRegions(parentId: Int?) -> Observable<[Region]>
    func getLanguages() -> Observable<[ModelWithIdAndName]>
}

struct EditInfographicsViewUseCase: EditInfographicsViewUseCaseType, EditInfographicsDomainUseCase {
    var gateway: EditInfographicsGatewayType
}
