//
//  User+API.swift
//  AkfaSmart
//
//  Created by Temur on 05/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Alamofire
import Foundation
extension API {
    func getGeneralUserInfo(_ input: GetGeneralUserInfoInput) -> Observable<GeneralUser> {
        request(input)
    }
    
    final class GetGeneralUserInfoInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getGeneralUserInfo, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}


extension API {
    func uploadAvatarImage(_ input: UploadImageInput) -> Observable<Bool> {
        return successPrimitive(input)
    }
    
    final class UploadImageInput: APIUploadInputBase {
        init(data: Data) {
            let uploadData = APIUploadData(data: data, name: "img", fileName: UUID().uuidString + ".jpeg", mimeType: "image/jpeg")
            super.init(data: [uploadData], urlString: API.Urls.saveAvatarImage, parameters: nil, method: .post, requireAccessToken: true)
        }
    }
}

extension API {
    final class GetUnreadDataCount: APIInput {
        init() {
            super.init(urlString: API.Urls.getUnreadData, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}
