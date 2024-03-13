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
            
            var params: Parameters = [:]
            if let firstNameEdited = graphics.firstNameEdited {
                params["firstNameEdited"] = firstNameEdited
            }
            
            if let middleName = graphics.middleNameEdited {
                params["middleNameEdited"] = middleName
            }
            
            if let lastNameEdited = graphics.lastNameEdited {
                params["lastNameEdited"] = lastNameEdited
            }
            
            if let addressEdited = graphics.addressEdited {
                params["addressEdited"] = addressEdited
            }
            
            if let nationEdited = graphics.nationEdited {
                params["nationEdited"] = nationEdited
            }
            
            if let educationEdited = graphics.educationEdited {
                params["educationEdited"] = educationEdited
            }
            
            if let numberOfChildrenEdited = graphics.numberOfChildrenEdited {
                params["numberOfChildrenEdited"] = numberOfChildrenEdited
            }
            
            if !graphics.ownedLanguagesEdited.isEmpty {
                params["languageIdsEdited"] = graphics.ownedLanguagesEdited.map { $0.id}
            }
            
            if let married = graphics.isMarriedEdited {
                params["isMarriedEdited"] = married
            }
            
            if let region = graphics.regionEdited.id {
                params["regionIdEdited"] = region
            }
            
            if let dateOfBirthEdited = graphics.dateOfBirthEdited, !dateOfBirthEdited.isEmpty {
                params["dateOfBirthEdited"] = dateOfBirthEdited
            }
            
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
    
    func saveTechnographics(_ input: SaveTechnographicsAPIInput) -> Observable<Bool> {
        success(input)
    }
    
    final class SaveTechnographicsAPIInput: APIInput {
        init(_ model: TechnoGraphics) {
            var params: Parameters = [:]
            
            if let longitudeEdited = model.longitudeEdited {
                params["longitudeEdited"] = longitudeEdited
            }
            
            if let latitudeEdited = model.latitudeEdited {
                params["latitudeEdited"] = latitudeEdited
            }
            
            if let areaEdited = model.areaEdited {
                params["areaEdited"] = areaEdited
            }
            
            if let hasGlassWorkshopEdited = model.hasGlassWorkshopEdited {
                params["hasGlassWorkshopEdited"] = hasGlassWorkshopEdited
            }
            
            if !model.toolsEdited.isEmpty {
                params["toolsEdited"] = model.toolsEdited.map({ $0.id })
            }
            
            super.init(urlString: API.Urls.editTechnoGraphics, parameters: params, method: .post, encoding: JSONEncoding.prettyPrinted, requireAccessToken: true)
        }
    }
}

extension API {
    func getSeries(_ input: GetSeriesAPIInput) -> Observable<[ModelWithIdAndName]> {
        requestList(input)
    }
    
    final class GetSeriesAPIInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getSeries, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}

extension API {
    func getTools(_ input: APIInput) -> Observable<[ModelWithIdAndName]> {
        requestList(input)
    }
    
    final class GetToolsAPIInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getTools, parameters: nil, method: .get, requireAccessToken: true)
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
    
    func editHRGraphics(_ input: EditHRGraphics) -> Observable<Bool> {
        success(input)
    }
    
    final class EditHRGraphics: APIInput {
        init(_ model: HRGraphics) {
            var params: Parameters = [:]
            if let aboutEmployeesEdited = model.aboutEmployeesEdited {
                params["aboutEmployeesEdited"] = aboutEmployeesEdited
            }
                
            if let hasAccountantEdited = model.hasAccountantEdited {
                params["hasAccountantEdited"] = hasAccountantEdited
            }
            if let hasSellerEdited = model.hasSellerEdited {
                params["hasSellerEdited"] = hasSellerEdited
            }
            if let numberOfEmployeesEdited = model.numberOfEmployeesEdited {
                params["numberOfEmployeesEdited"] = numberOfEmployeesEdited
            }
            if !model.userAttendantTrainingsEdited.isEmpty {
                params["userAttendantTrainingsEdited"] = model.userAttendantTrainingsEdited.map({ $0.id })
            }
            super.init(urlString: API.Urls.editHRGraphics, parameters: params, method: .post,encoding: JSONEncoding.prettyPrinted, requireAccessToken: true)
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
