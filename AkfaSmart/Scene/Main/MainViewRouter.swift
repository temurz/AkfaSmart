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
    
    
    var pages: [TabBarItem] = [TabBarItem(imageName: "home_tab_icon", title: "HOME".localizedString, id: MainPage.home.rawValue),
                               TabBarItem(imageName: "catalog_tab_icon", title: "ARTICLES".localizedString, id: MainPage.catalog.rawValue),
                               TabBarItem(imageName: "search_tab_icon", title: "SEARCH".localizedString, id: MainPage.add.rawValue),
                               TabBarItem(imageName: "news_tab_icon", title: "NEWS".localizedString, id: MainPage.news.rawValue),
                               TabBarItem(imageName: "settings_tab_icon", title: "SETTINGS_TITLE".localizedString, id: MainPage.settings.rawValue)]
    
    @Published var selectedPageId: String = MainPage.home.rawValue
    @Published var body: AnyView
    
    var showSideMenu: (() -> Void)?
    
    func route(selectedPageId: String) {
        if self.selectedPageId == selectedPageId {
            return
        }
        self.selectedPageId = selectedPageId
        switch selectedPageId {
        case MainPage.home.rawValue:
            var view: HomeView = assembler.resolve(navigationController: navigationController)
            view.showSideMenuAction = { [weak self] in
                self?.showSideMenu?()
            }
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
    
    init(assembler: Assembler, navigationController: UINavigationController, page: MainPage = .home){
        self.navigationController  = navigationController
        self.assembler = assembler
//        self.homeView = assembler.resolve(navigationController: navigationController)
        let view: HomeView = assembler.resolve(navigationController: navigationController)
        self.body = AnyView(view)
        var newView: HomeView = assembler.resolve(navigationController: navigationController)
        newView.showSideMenuAction = { [weak self] in
            self?.showSideMenu?()
        }
        self.body = AnyView(newView)
        if page != .home {
            self.route(selectedPageId: page.rawValue)
        }
        self.selectedPageId = page.rawValue
        
    }
    
}
