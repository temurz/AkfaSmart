//
//  LanguageViewNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 10/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol LanguageViewNavigatorType {    
    func popViewController()
    func showMain(page: MainPage)
}

struct LanguageViewNavigator: LanguageViewNavigatorType, ShowingMain {
    unowned var assembler: Assembler
    
    unowned var navigationController: UINavigationController
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
}
