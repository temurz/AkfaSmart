//
//  APIUrls.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/31/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

extension API {
    enum Urls {
        static let getRepoList = "https://api.github.com/search/repositories"
        
        static let login = Base.BASE_URL + "/api/mobile/auth/login"
        
        //Register
        static let register = Base.BASE_URL + "/api/mobile/auth/register"
        static let confirmRegister = Base.BASE_URL + "/api/mobile/auth/register/confirm"
        static let resendRegisterCode = Base.BASE_URL + "/api/mobile/auth/register/resend"
        
        //Forgot Password
        static let confirmForgotPassword = Base.BASE_URL + "/api/mobile/auth/forget/confirm"
        static let requestSMSCodeOnForgotPassword = Base.BASE_URL + "/api/mobile/auth/forget"
        static let resendForgotPassword = Base.BASE_URL + "/api/mobile/auth/forget/resend"
        static let resetPassword = Base.BASE_URL + "/api/mobile/auth/reset/password"
        
        //News and Articles
        static let getNews = Base.BASE_URL + "/api/mobile/news/data"
        static let getArticles = Base.BASE_URL + "/api/mobile/article/data"
        
        //Dealers
        static let getDealersInfo = Base.BASE_URL + "/api/mobile/adwdealer/view"
        static let hasADealerCheck = Base.BASE_URL + "/api/mobile/adwdealer/hasDealer"
        static let hasADealerAndLocationCheck = Base.BASE_URL + "/api/mobile/adwdealer/hasDealerAndLocation"
        
        //MobileClass
        static let getMobileClassInfo = Base.BASE_URL + "/api/mobile/mobile_user/klass"
        static let getMobileClassDetail = Base.BASE_URL + "/api/mobile/mobile_user/klass_detail"
        static let getMobileClassImageLogo = Base.BASE_URL + "/api/mobile/mobile_user/klass_logo/"
        
    }
}
