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
        static let getArticleTypes = Base.BASE_URL + "/api/mobile/articleType/view"
        
        //Dealers
        static let getDealersInfo = Base.BASE_URL + "/api/mobile/adwdealer/view"
        static let hasADealerCheck = Base.BASE_URL + "/api/mobile/adwdealer/hasDealer"
        static let hasADealerAndLocationCheck = Base.BASE_URL + "/api/mobile/adwdealer/hasDealerAndLocation"
        //AddDealer
        static let addDealer_sendQRCode = Base.BASE_URL + "/api/mobile/dealer_client"
        static let addDealer_requestSMSCode = Base.BASE_URL + "/api/mobile/dealer_client/sms/send"
        static let addDealer_resendSMSCode = Base.BASE_URL + "/api/mobile/dealer_client/sms/resend"
        static let addDealer_confirmSMSCode = Base.BASE_URL + "/api/mobile/dealer_client/sms/confirm"
        static let addDealer_requestSMSCodeForActiveDealer = Base.BASE_URL + "/api/mobile/dealer_client/sms/reset/active/mob-dealer-client/send-code"
        static let addDealer_confirmSMSCodeForActiveDealer = Base.BASE_URL + "/api/mobile/dealer_client/sms/reset/active/mob-dealer-client"

        
        //MobileClass
        static let getMobileClassInfo = Base.BASE_URL + "/api/mobile/mobile_user/klass"
        static let getMobileClassDetail = Base.BASE_URL + "/api/mobile/mobile_user/klass_detail"
        static let getMobileClassImageLogo = Base.BASE_URL + "/api/mobile/mobile_user/klass_logo/"
        
        
        //Graphics
        static let getInfoGraphics = Base.BASE_URL + "/api/mobile/infographic"
        static let editInfoGraphics = Base.BASE_URL + "/api/mobile/infographic/edit"
        static let getRegions = Base.BASE_URL + "/api/mobile/region/view"
        static let getLanguages = Base.BASE_URL + "/api/mobile/language/view"
        
        static let getTechnoGraphics = Base.BASE_URL + "/api/mobile/technographic"
        static let editTechnoGraphics = Base.BASE_URL + "/api/mobile/technographic/edit"
        static let getTools = Base.BASE_URL + "/api/mobile/tool/view"
        static let getSeries = Base.BASE_URL + "/api/mobile/klass_group/view"
        
        static let getHRGraphics = Base.BASE_URL + "/api/mobile/HRgraphic"
        static let editHRGraphics = Base.BASE_URL + "/api/mobile/HRgraphic/edit"
        
        static let getMarketingGraphics = Base.BASE_URL + "/api/mobile/marketing"
        static let getProductGraphics = Base.BASE_URL + "/api/mobile/productgraphic"
        
        //Invoice
        static let getInvoiceList = Base.BASE_URL + "/api/mobile/invoice/list"
        static let getInvoiceListById = Base.BASE_URL + "/api/mobile/invoice/items"
        static let getInvoiceElectronCheque = Base.BASE_URL + "/api/mobile/summaryInvoice/electronCheque"
        
        //Receipt
        static let getReceiptList = Base.BASE_URL + "/api/mobile/payment_receipt/list"

        //Products
        static let getProductsList = Base.BASE_URL + "/api/mobile/product/list"
        static let getProductsListByNameAndLocation = Base.BASE_URL + "/api/mobile/product/listByProductName"

        //User
        static let getGeneralUserInfo = Base.BASE_URL + "/api/mobile/mobile_user/userInfo"
        static let saveAvatarImage = Base.BASE_URL + "/api/mobile/mobile_user/save/img"
        static let getUnreadData = Base.BASE_URL + "/api/mobile/mobile_user/unreadData"
        
        //Messages
        static let getMessages = Base.BASE_URL + "/api/mobile/message/data"
        static let sendMessage = Base.BASE_URL + "/api/mobile/message/save"
        static let clearMessagesHistory = Base.BASE_URL + "/api/mobile/message/clearAll"
        
        //Cards
        static let addCard = Base.BASE_URL + "/api/mobile/loyaltyCard/join"
        static let activateCard = Base.BASE_URL + "/api/mobile/loyaltyCard/activate"
        static let blockCard = Base.BASE_URL + "/api/mobile/loyaltyCard/block"
        static let unblockCard = Base.BASE_URL + "/api/mobile/loyaltyCard/unblock"
        static let confirmCardAction = Base.BASE_URL + "/api/mobile/loyaltyCard/confirm/"
        static let resendCardAction = Base.BASE_URL + "/api/mobile/loyaltyCard/resend/"
        static let cardSettings = Base.BASE_URL + "/api/mobile/loyaltyCard/settings"
        static let deleteCard = Base.BASE_URL + "/api/mobile/loyaltyCard/delete"
        static let getCards = Base.BASE_URL + "/api/mobile/loyaltyCard/balance"
    }
}
