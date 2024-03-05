//
//  UserInfoGateway.swift
//  AkfaSmart
//
//  Created by Temur on 05/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol UserInfoGatewayType {
    func getGeneralUserInfo() -> Observable<GeneralUser>
    func setAvatarImage(data: Data) -> Observable<Bool>
}

struct UserInfoGateway: UserInfoGatewayType {
    func setAvatarImage(data: Data) -> Observable<Bool> {
        let input = API.UploadImageInput(data: data)
        return API.shared.uploadAvatarImage(input)
//            .tryMap { imageURL in
//                return imageURL.isEmpty ? false : true
//            }
//            .eraseToAnyPublisher()
    }
    
    func getGeneralUserInfo() -> Observable<GeneralUser> {
        let input = API.GetGeneralUserInfoInput()
        return API.shared.getGeneralUserInfo(input)
    }
}
