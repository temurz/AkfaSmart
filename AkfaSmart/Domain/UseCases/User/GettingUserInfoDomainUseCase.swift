//
//  GettingUserInfoDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 05/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol GettingUserInfoDomainUseCase {
    var gateway: UserInfoGatewayType { get }
}

extension GettingUserInfoDomainUseCase {
    func getGeneralUserInfo() -> Observable<GeneralUser> {
        gateway.getGeneralUserInfo()
    }
    
    func setAvatarImage(data: Data) -> Observable<Bool> {
        gateway.setAvatarImage(data: data)
    }
}
