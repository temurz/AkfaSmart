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
}

struct PINCodeViewNavigator: PINCodeViewNavigatorType, ShowingMain, ShowingWelcomeView {
    var assembler: Assembler
    
    var navigationController: UINavigationController
    
    func goToMainOrPop() {
        if navigationController.viewControllers.count == 1 {
            showMain(page: .home)
        }else {
            navigationController.popViewController(animated: true)
        }
    }
    
    func popView() {
        navigationController.popViewController(animated: true)
    }
}
