//
//  ResetPasswordNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 21/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol ResetPasswordNavigatorType {
    func showLogin()
    func popView()
}

struct ResetPasswordNavigator: ResetPasswordNavigatorType, ShowingLogin, PoppingController {
    var assembler: Assembler
    var navigationController: UINavigationController
}
