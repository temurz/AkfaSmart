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
    func clearHistory() -> Observable<Bool>
    func sendMessage(message: MessageWithData) -> Observable<MessageModel>
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
    
    func clearHistory() -> Observable<Bool> {
        let input = API.ClearMessagesHistoryAPIInput()
        return API.shared.clearMessagesHistory(input)
    }
    
    func sendMessage(message: MessageWithData) -> Observable<MessageModel> {
        let input = API.SendMessageAPIInput(message: message)
        return API.shared.sendMessage(input)
    }
    
}
