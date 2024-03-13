//
//  InfoGraphics.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import Alamofire
//InfoGraphics
extension API {
    func getInfoGraphics(_ input: InfoGraphicsInput) -> Observable<Infographics> {
        return request(input)
    }
    
    final class InfoGraphicsInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getInfoGraphics, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}

extension API {
    func editInfographics(_ input: EditInfoGraphicsAPIInput) -> Observable<Bool> {
        success(input)
    }
    
    
    final class EditInfoGraphicsAPIInput: APIInput {
        init(graphics: Infographics) {
            
            let params: Parameters = [
                  "id": 0,
                  "status": "CREATED",
                  "createdAt": "2024-03-12T16:36:50.366Z",
                  "updatedAt": "2024-03-12T16:36:50.366Z",
                  "createdBy": 0,
                  "updatedBy": 0,
                  "firstName": graphics.firstName ?? "",
                  "firstNameEdited": graphics.firstNameEdited ?? "",
                  "middleName": graphics.middleName ?? "",
                  "middleNameEdited": graphics.middleNameEdited ?? "",
                  "lastName": graphics.lastName ?? "",
                  "lastNameEdited": graphics.lastNameEdited ?? "",
                  "dateOfBirth": graphics.dateOfBirth ?? "",
                  "dateOfBirthEdited": graphics.dateOfBirthEdited ?? "",
                  "regionId": graphics.region.id ?? 0,
                  "regionIdEdited": graphics.regionEdited.id ?? 0,
                  "address": graphics.address ?? "",
                  "addressEdited": graphics.addressEdited ?? "",
                  "nation": graphics.nation ?? "",
                  "nationEdited": graphics.nationEdited ?? "",
                  "education": graphics.education ?? "",
                  "educationEdited": graphics.educationEdited ?? "",
                  "isMarried": graphics.isMarried ?? false,
                  "isMarriedEdited": graphics.isMarriedEdited ?? false,
                  "numberOfChildren": graphics.numberOfChildren ?? 0,
                  "numberOfChildrenEdited": graphics.numberOfChildrenEdited ?? 0,
                  "languageIds": graphics.ownedLanguages.map { $0.id },
                  "languageIdsEdited": graphics.ownedLanguagesEdited.map { $0.id},
                  "klassId": 0,
//                  "klassCriterias": {},
                  "uniqueId": 0
            ]
            
            super.init(urlString: API.Urls.editInfoGraphics, parameters: params, method: .post, encoding: JSONEncoding.prettyPrinted, requireAccessToken: true)
        }
    }
}

extension API {
    func getRegions(_ input: GetRegionsAPIInput) -> Observable<[Region]> {
        requestList(input)
    }
    
    final class GetRegionsAPIInput: APIInput {
        init(parentId: Int?) {
            var params: Parameters? = nil
            if let parentId {
                params = [
                    "parentId": parentId
                ]
            }
            super.init(urlString: API.Urls.getRegions, parameters: params, method: .get, requireAccessToken: true)
        }
    }
}

extension API {
    func getLanguages(_ input: GetLanguagesAPIInput) -> Observable<[ModelWithIdAndName]> {
        requestList(input)
    }
    
    final class GetLanguagesAPIInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getLanguages, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}

//TechnoGraphics
extension API {
    func getTechnoGraphics(_ input: TechnoGraphicsInput) -> Observable<TechnoGraphics> {
        return request(input)
    }
    
    final class TechnoGraphicsInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getTechnoGraphics, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}

//HRGraphics
extension API {
    func getHRGraphics(_ input: HRGraphicsInput) -> Observable<HRGraphics> {
        request(input)
    }
    
    final class HRGraphicsInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getHRGraphics, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}


//MarketingGraphics
extension API {
    func getMarketingGraphics(_ input: GetMarketingGraphicsInput) -> Observable<MarketingGraphics> {
        request(input)
    }
    
    final class GetMarketingGraphicsInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getMarketingGraphics, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}


extension API {
    func getProductGraphics(_ input: GetProductGraphicsInput) -> Observable<ProductGraphics> {
        request(input)
    }
    
    final class GetProductGraphicsInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getProductGraphics, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}
