//
//  MainUseCase.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

protocol MainUseCaseType {
    func getGeneralUserInfo() -> Observable<GeneralUser> 
}

struct MainUseCase: MainUseCaseType, GettingUserInfoDomainUseCase {
    var gateway: UserInfoGatewayType
}
