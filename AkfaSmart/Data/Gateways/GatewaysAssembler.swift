//
//  GatewaysAssembler.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

protocol GatewaysAssembler {
    func resolve() -> ProductGatewayType
    func resolve() -> AuthGatewayType
    func resolve() -> RepoGatewayType
    func resolve() -> RegisterGatewayType
    func resolve() -> CodeInputGatewayType
    func resolve() -> ForgotPasswordGatewayType
}

extension GatewaysAssembler where Self: DefaultAssembler {
    func resolve() -> ProductGatewayType {
        ProductGateway()
    }

    func resolve() -> AuthGatewayType {
        AuthGateway()
    }

    func resolve() -> RepoGatewayType {
        RepoGateway()
    }
    
    func resolve() -> RegisterGatewayType {
        RegisterGateway()
    }
    
    func resolve() -> CodeInputGatewayType {
        CodeInputGateway()
    }
    
    func resolve() -> NewsGatewayType {
        NewsGateway()
    }
    
    func resolve() -> ArticlesGatewayType {
        ArticlesGateway()
    }
    
    func resolve() -> ForgotPasswordGatewayType {
        ForgotPasswordGateway()
    }
    
    func resolve() -> ResendSMSGatewayType {
        ResendSMSGateway()
    }
    
    func resolve() -> ConfirmSMSCodeOnForgotPasswordGatewayType {
        ConfirmSMSCodeOnForgotPasswordGateway()
    }
    
    func resolve() -> ResetPasswordGatewayType {
        ResetPasswordGateway()
    }
    
    func resolve() -> GetDealersGatewayType {
        GetDealersGateway()
    }
    
    func resolve() -> MobileClassGatewayType {
        return MobileClassGateway()
    }
    
    func resolve() -> AddDealerGatewayType {
        return AddDealerGateway()
    }
    
    func resolve() -> ClassDetailGatewayType {
        return ClassDetailGateway()
    }
    
    func resolve() -> InvoiceListGatewayType {
        return InvoiceListGateway()
    }
    
    func resolve() -> ProductsListGatewayType {
        return ProductsListGateway()
    }
    
    func resolve() -> ProductDealersListGatewayType {
        return ProductDealersListGateway()
    }
    
    func resolve() -> UserInfoGatewayType {
        return UserInfoGateway()
    }
    
    func resolve() -> ImageDownloaderGatewayType {
        return ImageDownloaderGateway()
    }
    
    func resolve() -> ArticleTypeGatewayType {
        return ArticleTypeGateway()
    }
    
    func resolve() -> PaymentReceiptsGatewayType {
        return PaymentReceiptsGateway()
    }
    
    func resolve() -> InvoiceDetailGatewayType {
        return InvoiceDetailGateway()
    }
    
    func resolve() -> EditInfographicsGatewayType {
        return EditInfographicsGateway()
    }
    
    func resolve() -> InfoGraphicsGatewayType {
        return InfoGraphicsGateway()
    }
    
    func resolve() -> EditTechnographicsGatewayType {
        return EditTechnographicsGateway()
    }
    
    func resolve() -> HRGatewayType {
        return HRGateway()
    }
    
    func resolve() -> HRGraphicsEditGatewayType {
        return HRGraphicsEditGateway()
    }
    
    func resolve() -> GetCardsGatewayType {
        return GetCardsGateway()
    }
}

extension GatewaysAssembler where Self: PreviewAssembler {
    func resolve() -> ProductGatewayType {
        PreviewProductGateway()
    }
    
    func resolve() -> AuthGatewayType {
        AuthGateway()
    }
    
    func resolve() -> RepoGatewayType {
        RepoGateway()
    }
    
    func resolve() -> RegisterGatewayType {
        RegisterGateway()
    }
    
    func resolve() -> CodeInputGatewayType {
        CodeInputGateway()
    }
    
    func resolve() -> NewsGatewayType {
        NewsGateway()
    }
    
    func resolve() -> ArticlesGatewayType {
        ArticlesGateway()
    }
    
    func resolve() -> ForgotPasswordGatewayType {
        ForgotPasswordGateway()
    }
    
    func resolve() -> ResendSMSGatewayType {
        ResendSMSGateway()
    }
    func resolve() -> ConfirmSMSCodeOnForgotPasswordGatewayType {
        ConfirmSMSCodeOnForgotPasswordGateway()
    }
    
    func resolve() -> ResetPasswordGatewayType {
        ResetPasswordGateway()
    }
    
    func resolve() -> GetDealersGatewayType {
        GetDealersGateway()
    }
    
    func resolve() -> MobileClassGatewayType {
        return MobileClassGateway()
    }
    
    func resolve() -> AddDealerGatewayType {
        return AddDealerGateway()
    }
    
    func resolve() -> ClassDetailGatewayType {
        return ClassDetailGateway()
    }
    
    func resolve() -> InvoiceListGatewayType {
        return InvoiceListGateway()
    }
    
    func resolve() -> ProductsListGatewayType {
        return ProductsListGateway()
    }
    
    func resolve() -> ProductDealersListGatewayType {
        return ProductDealersListGateway()
    }
    
    func resolve() -> UserInfoGatewayType {
        return UserInfoGateway()
    }
    
    func resolve() -> ImageDownloaderGatewayType {
        return ImageDownloaderGateway()
    }
    
    func resolve() -> ArticleTypeGatewayType {
        return ArticleTypeGateway()
    }
    
    func resolve() -> PaymentReceiptsGatewayType {
        return PaymentReceiptsGateway()
    }
    
    func resolve() -> InvoiceDetailGatewayType {
        return InvoiceDetailGateway()
    }
    
    func resolve() -> EditInfographicsGatewayType {
        return EditInfographicsGateway()
    }
    
    func resolve() -> InfoGraphicsGatewayType {
        return InfoGraphicsGateway()
    }
    
    func resolve() -> EditTechnographicsGatewayType {
        return EditTechnographicsGateway()
    }
    
    func resolve() -> HRGatewayType {
        return HRGateway()
    }
    
    func resolve() -> HRGraphicsEditGatewayType {
        return HRGraphicsEditGateway()
    }
    
    func resolve() -> GetCardsGatewayType {
        return GetCardsGateway()
    }
}
