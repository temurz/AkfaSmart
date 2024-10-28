//
//  PINCodeViewNavigatorType.swift
//  AkfaSmart
//
//  Created by Temur on 19/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol PINCodeViewNavigatorType {
    func goToMainOrPop()
    func showMain(page: MainPage)
    func popView()
    func showWelcomeView()
    func checkHasParentController() -> Bool
}

struct PINCodeViewNavigator: PINCodeViewNavigatorType, ShowingMain, ShowingWelcomeView, PoppingController {
    var assembler: Assembler
    
    var navigationController: UINavigationController
    
    func goToMainOrPop() {
        if navigationController.viewControllers.count == 1 {
            showMain(page: .home)
        }else {
            navigationController.popViewController(animated: true)
        }
    }
    
    func checkHasParentController() -> Bool {
        navigationController.viewControllers.count > 1
    }
}
