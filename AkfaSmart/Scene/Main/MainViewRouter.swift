//
//  MainViewRouter.swift
//  AkfaSmart
//
//  Created by Temur on 01/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
enum MainPage: String{
    case home
    case catalog
    case add
    case news
    case settings
}

class MainViewRouter: ViewRouter {
    let navigationController: UINavigationController
    let assembler: Assembler
    
    
    var pages: [TabBarItem] = [TabBarItem(imageName: "house", title: "Home", id: MainPage.home.rawValue),
                               TabBarItem(imageName: "square.stack.3d.up", title: "Catalogs", id: MainPage.catalog.rawValue),
                               TabBarItem(imageName: "plus.app", title: "Search", id: MainPage.add.rawValue),
                               TabBarItem(imageName: "doc.plaintext", title: "News", id: MainPage.news.rawValue),
                               TabBarItem(imageName: "gearshape", title: "Settings", id: MainPage.settings.rawValue)]
    
    @Published var selectedPageId: String = MainPage.home.rawValue
    @Published var body: AnyView
    
    func route(selectedPageId: String) {
        self.selectedPageId = selectedPageId
        switch selectedPageId {
        case MainPage.home.rawValue:
            let view: HomeView = assembler.resolve(navigationController: navigationController)
            body = AnyView(view)
            break
        case MainPage.catalog.rawValue:
            let view:ArticlesView = assembler.resolve(navigationController: navigationController)
            
            body = AnyView(view)
            break
        case MainPage.add.rawValue:
            let view: SearchProductView = assembler.resolve(navigationController: navigationController)
            body = AnyView(view)
        case MainPage.news.rawValue:
            let view: NewsView = assembler.resolve(navigationController: navigationController)
            
            body = AnyView(view)
            break
        case MainPage.settings.rawValue:
            let view: SettingsView = assembler.resolve(navigationController: navigationController)
            
            body = AnyView(view)
            break
        default:
            body = AnyView(Text("DEFAULT"))
            break
        }
    }
    
    init(assembler: Assembler, navigationController: UINavigationController){
        self.navigationController  = navigationController
        self.assembler = assembler
//        self.homeView = assembler.resolve(navigationController: navigationController)
        let view: HomeView = assembler.resolve(navigationController: navigationController)
        self.body = AnyView(view)
        
    }
    
}
