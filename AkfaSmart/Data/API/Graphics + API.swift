//
//  InfoGraphics.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
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
