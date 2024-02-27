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
        //AddDealer
        static let addDealer_sendQRCode = Base.BASE_URL + "/api/mobile/dealer_client"
        static let addDealer_requestSMSCode = Base.BASE_URL + "/api/mobile/dealer_client/sms/send"
        static let addDealer_resendSMSCode = Base.BASE_URL + "/api/mobile/dealer_client/sms/resend"
        static let addDealer_confirmSMSCode = Base.BASE_URL + "/api/mobile/dealer_client/sms/confirm"

        
        //MobileClass
        static let getMobileClassInfo = Base.BASE_URL + "/api/mobile/mobile_user/klass"
        static let getMobileClassDetail = Base.BASE_URL + "/api/mobile/mobile_user/klass_detail"
        static let getMobileClassImageLogo = Base.BASE_URL + "/api/mobile/mobile_user/klass_logo/"
        
        
        //Graphics
        static let getInfoGraphics = Base.BASE_URL + "/api/mobile/infographic"
        static let editInfoGraphics = Base.BASE_URL + "/api/mobile/infographic/edit"
        
        static let getTechnoGraphics = Base.BASE_URL + "/api/mobile/technographic"
        static let editTechnoGraphics = Base.BASE_URL + "/api/mobile/technographic/edit"
        
        static let getHRGraphics = Base.BASE_URL + "/api/mobile/HRgraphic"
        
        
    }
}
