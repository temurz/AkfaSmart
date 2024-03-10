//
//  MessagesGateway.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 11/03/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation

protocol MessagesGatewayType {
    func getMessages (dto:GetPageDto) -> Observable <PagingInfo<MessageModel>>
}

struct MessagesGateway: MessagesGatewayType {
    func getMessages(dto: GetPageDto) -> Observable<PagingInfo<MessageModel>> {
        let input = API.GetMessagesAPIInput(dto: dto)
        return API.shared.getMessages(input)
            .tryMap { output in
                return output.rows
            }
            .replaceNil(with: [])
            .map{PagingInfo(page: dto.page, items: $0, hasMorePages: $0.count==dto.perPage)}
            .eraseToAnyPublisher()
    }
    
    
}
