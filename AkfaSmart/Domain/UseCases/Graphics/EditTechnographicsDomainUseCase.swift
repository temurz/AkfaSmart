//
//  EditTechnographicsDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol EditTechnographicsDomainUseCase {
    var gateway: EditTechnographicsGatewayType { get }
}

extension EditTechnographicsDomainUseCase {
    func getSeries() -> Observable<[ModelWithIdAndName]> {
        gateway.getSeries()
    }
    
    func getTools() -> Observable<[ModelWithIdAndName]> {
        gateway.getTools()
    }
    
    func save(_ model: TechnoGraphics) -> Observable<Bool> {
        gateway.save(model)
    }
}
