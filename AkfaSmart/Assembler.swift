//
//  Assembler.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

protocol Assembler: AnyObject,
    ReposAssembler,
    ProductDetailAssembler,
    ProductsAssembler,
    MainAssembler,
    LoginAssembler,
    GatewaysAssembler,
    AppAssembler,
    RegisterAssembler,
    CodeInputAssembler,
    NewsAssembler,
    ArticlesAssembler,
    SettingsAssembler,
    HomeViewAssembler,
    SearchProductViewAssembler,
    AddDealerAssembler,
    WelcomeViewAssembler,
    SplashViewAssembler,
    ForgotPasswordAssembler,
    ResetPasswordAssembler,
    AddDealerAssembler,
    ClassDetailViewAssembler,
    PurchaseHistoryAssembler,
    ProductDealersListViewAssembler,
    ArticlesFilterViewAssembler,
    PaymentHistoryViewAssembler,
    PurchaseDetailViewAssembler,
    EditInfographicsViewAssembler,
    InfographicsAssembler,
    EditTechnographicsAssembler
{
    
}

final class DefaultAssembler: Assembler {
    
}

final class PreviewAssembler: Assembler {
    
}
