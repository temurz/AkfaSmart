//
//  MobileClass+API.swift
//  AkfaSmart
//
//  Created by Temur on 25/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
extension API {
    func getUserClassInfo(_ input: GetMobileClassInfoInput) -> Observable<MobileClass> {
        request(input)
    }
    
    final class GetMobileClassInfoInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getMobileClassInfo, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}


extension API {
    func getUserClassImage(_ input: GetImageInput) -> Observable<Data> {
        return requestImage(input)
    }
    
    final class GetImageInput: APIInput {
        init(_ urlString: String) {
            
            super.init(urlString: urlString, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}

extension API {
    func getUserClassDetail(_ input: GetUserClassDetailInput) -> Observable<[MobileClassDetail]> {
        requestList(input)
    }
    
    final class GetUserClassDetailInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getMobileClassDetail, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}
