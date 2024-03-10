//
//  TechnicalSupportUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 10/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol TechnicalSupportUseCaseType {
    func getMessages(page: Int) -> Observable<PagingInfo<MessageModel>>
}

struct TechnicalSupportUseCase: TechnicalSupportUseCaseType, GettingMessagesDomainUseCase {
    var gateway: MessagesGatewayType
}
