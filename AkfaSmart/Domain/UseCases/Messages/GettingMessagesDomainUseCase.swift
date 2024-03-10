//
//  GettingMessagesDomainUseCase.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 11/03/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation

protocol GettingMessagesDomainUseCase {
    var gateway: MessagesGatewayType { get }
}

extension GettingMessagesDomainUseCase {
    func getMessages (page: Int) -> Observable <PagingInfo<MessageModel>>
    {
        let dto = GetPageDto(page: page)
        return gateway.getMessages(dto: dto)
    }
}