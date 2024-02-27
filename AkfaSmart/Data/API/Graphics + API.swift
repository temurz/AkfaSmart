//
//  InfoGraphics.swift
//  AkfaSmart
//
//  Created by Temur on 27/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
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
