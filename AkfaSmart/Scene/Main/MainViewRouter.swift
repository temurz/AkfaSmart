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
                               TabBarItem(imageName: "plus.app", title: "Create order", id: MainPage.add.rawValue),
                               TabBarItem(imageName: "doc.plaintext", title: "News", id: MainPage.news.rawValue),
                               TabBarItem(imageName: "gearshape", title: "Settings", id: MainPage.settings.rawValue)]
    
    @Published var selectedPageId: String = MainPage.home.rawValue
    @Published var body: AnyView
    
    func route(selectedPageId: String) {
        self.selectedPageId = selectedPageId
        switch selectedPageId {
        case MainPage.home.rawValue:
            
            body = AnyView(VStack{
                Spacer()
                Text("Home View")
            })
            break
        case MainPage.catalog.rawValue:
            let v:ArticlesView = assembler.resolve(navigationController: navigationController)
            body = AnyView(v)
            break
        case MainPage.add.rawValue:
            break
        case MainPage.news.rawValue:
            let v: NewsView = assembler.resolve(navigationController: navigationController)
            
            body = AnyView(v)
            break
        case MainPage.settings.rawValue:
            let settingsView: SettingsView = assembler.resolve(navigationController: navigationController)
            body = AnyView(settingsView)
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
        self.body = AnyView(VStack{ Spacer() })
        
    }
    
}
