//
//  Card+API.swift
//  AkfaSmart
//
//  Created by Temur on 26/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
extension API {
    func addCard(_ input: AddCardInput) -> Observable<Bool> {
        success(input)
    }
    
    final class AddCardInput: APIInput {
        init(cardNumber: String) {
            let parameters = ["cardNumber": cardNumber]
            super.init(urlString: API.Urls.addCard, parameters: parameters, method: .post, requireAccessToken: true)
        }
    }
}

extension API {
    func activateCard(_ input: ActivateCardInput) -> Observable<Bool> {
        success(input)
    }
    
    final class ActivateCardInput: APIInput {
        init(cardNumber: String, confirmationCode: String) {
            let parameters = [
                "cardNumber": cardNumber,
                "confirmationCode": confirmationCode
            ]
            super.init(urlString: API.Urls.activateCard, parameters: parameters, method: .post, requireAccessToken: true)
        }
    }
}

extension API {
    func blockCard(_ input: BlockCardInput) -> Observable<Bool> {
        success(input)
    }
    
    final class BlockCardInput: APIInput {
        init(id: Int) {
            let parameters = [
                "id": id
            ]
            super.init(urlString: API.Urls.blockCard, parameters: parameters, method: .post, requireAccessToken: true)
        }
    }
}

extension API {
    func unblockCard(_ input: UnblockCardInput) -> Observable<Bool> {
        success(input)
    }
    
    final class UnblockCardInput: APIInput {
        init(id: Int, connectedPhone: String) {
            let parameters: [String: Any] = [
                "id": id,
                "connectedPhone": connectedPhone
            ]
            super.init(urlString: API.Urls.unblockCard, parameters: parameters, method: .post, requireAccessToken: true)
        }
    }
}

extension API {
    func confirmCardAction(_ input: ConfirmCardActionInput) -> Observable<Bool> {
        success(input)
    }
    
    final class ConfirmCardActionInput: APIInput {
        init(action: String, id: Int, confirmationCode: String) {
            let parameters: [String: Any] = [
                "id": id,
                "confirmationCode": confirmationCode
            ]
            super.init(urlString: API.Urls.confirmCardAction + action, parameters: parameters, method: .post, requireAccessToken: true)
        }
    }
}

extension API {
    func resendCardAction(_ input: ResendCardActionInput) -> Observable<Bool> {
        success(input)
    }
    
    final class ResendCardActionInput: APIInput {
        init(action: String, id: Int) {
            let parameters: [String: Any] = [
                "id": id
            ]
            super.init(urlString: API.Urls.resendCardAction + action, parameters: parameters, method: .post, requireAccessToken: true)
        }
    }
}

extension API {
    func changeCardSettings(_ input: ChangeCardSettingsInput) -> Observable<Bool> {
        success(input)
    }
    
    final class ChangeCardSettingsInput: APIInput {
        init(cardCode: String, isMain: Bool, displayName: String, cardBackground: String) {
            let parameters: [String:Any] = [
                "cardCode": cardCode,
                "isMain": isMain,
                "displayName": displayName,
                "cardBackground": cardBackground
            ]
            super.init(urlString: API.Urls.cardSettings, parameters: parameters, method: .post, requireAccessToken: true)
        }
    }
}

extension API {
    func deleteCard(_ input: DeleteCardInput) -> Observable<Bool> {
        success(input)
    }
    
    final class DeleteCardInput: APIInput {
        init(id: Int) {
            let parameters: [String: Any] = [
                "id": id
            ]
            super.init(urlString: API.Urls.deleteCard, parameters: parameters, method: .post, requireAccessToken: true)
        }
    }
}

extension API {
    func getCards(_ input: GetCardsInput) -> Observable<[Card]> {
        requestList(input)
    }
    
    final class GetCardsInput: APIInput {
        init(cardNumber: String?) {
            var parameters: [String: Any]? = nil
            if let cardNumber {
                parameters = [
                    "cardNumber": cardNumber
                ]
            }
            super.init(urlString: API.Urls.getCards, parameters: parameters, method: .get, requireAccessToken: true)
        }
    }
}
