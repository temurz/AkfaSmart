//
//  SplashViewNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol SplashViewNavigatorType {
    func showMain(page: MainPage)
    func showLogin()
}

struct SplashViewNavigator: SplashViewNavigatorType, ShowingMain, ShowingLogin {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
