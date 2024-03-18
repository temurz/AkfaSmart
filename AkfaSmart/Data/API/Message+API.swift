//
//  Message+API.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 11/03/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import Alamofire
extension API {
    
    func getMessages(_ input:GetMessagesAPIInput) -> Observable<GetMessagesOutput> {
        request(input)
    }
    
    final class GetMessagesAPIInput: APIInput {
        init (dto:GetPageDto) {
            
            let parametres: [String : Any] = [
                "start": dto.page,
                "length": 10,
                "order": [
                    [
                        "field": "string",
                        "sort": "string"
                    ]
                ],
                "filter": [
                    "additionalProp1": "string",
                    "additionalProp2": "string",
                    "additionalProp3": "string"
                ]
            ]
            super.init(urlString: API.Urls.getMessages, parameters: parametres,  method: .post, encoding: JSONEncoding.prettyPrinted, requireAccessToken: true)
        }
    }
    
    final class GetMessagesOutput: Decodable {
        let total: Int
        let rows: [MessageModel]
    }
}

extension API {
    func clearMessagesHistory(_ input: ClearMessagesHistoryAPIInput) -> Observable<Bool> {
        success(input)
    }
    
    final class ClearMessagesHistoryAPIInput: APIInput {
        init() {
            super.init(urlString: API.Urls.clearMessagesHistory, parameters: nil, method: .delete, requireAccessToken: true)
        }
    }
}

extension API {
    func sendMessage(_ input: SendMessageAPIInput) -> Observable<MessageModel> {
        request(input)
    }
    final class SendMessageAPIInput: APIUploadInputBase {
        init(message: MessageWithData) {
            var text = ""
            if !message.text.isEmpty {
                text = "?text=\(message.text)"
            }
            
            let uploadData = APIUploadData(data: message.data ?? Data(), name: "files", fileName: UUID().uuidString + ".jpeg", mimeType: "image/jpeg")
            
            super.init(data: message.data != nil ? [uploadData] : [], urlString: API.Urls.sendMessage+text, parameters: nil, method: .post, requireAccessToken: true)
        }
    }
}
