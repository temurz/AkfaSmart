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
    CreateOrderAssembler,
    AddDealerAssembler {
    
}

final class DefaultAssembler: Assembler {
    
}

final class PreviewAssembler: Assembler {
    
}
