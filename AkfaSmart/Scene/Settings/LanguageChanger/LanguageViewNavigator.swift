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
}

struct LanguageViewNavigator: LanguageViewNavigatorType {
    unowned var assembler: Assembler
    
    unowned var navigationController: UINavigationController
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
}
