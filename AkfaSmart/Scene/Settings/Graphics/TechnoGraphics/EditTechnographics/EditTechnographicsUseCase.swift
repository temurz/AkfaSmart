//
//  EditTechnographicsUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol EditTechnographicsUseCaseType {
    func getSeries() -> Observable<[ModelWithIdAndName]>
    func getTools() -> Observable<[ModelWithIdAndName]>
    func save(_ model: TechnoGraphics) -> Observable<Bool>
}

struct EditTechnographicsUseCase: EditTechnographicsUseCaseType, EditTechnographicsDomainUseCase {
    var gateway: EditTechnographicsGatewayType
}
