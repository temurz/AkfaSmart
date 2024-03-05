//
//  SettingsUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol SettingsUseCaseType {
    func getGeneralUserInfo() -> Observable<GeneralUser>
    func setAvatarImage(data: Data) -> Observable<Bool>
}

struct SettingsUseCase: SettingsUseCaseType, GettingUserInfoDomainUseCase {
    var gateway: UserInfoGatewayType
}
