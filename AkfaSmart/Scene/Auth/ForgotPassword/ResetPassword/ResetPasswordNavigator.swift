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
}

struct ResetPasswordNavigator: ResetPasswordNavigatorType, ShowingLogin {
    var assembler: Assembler
    var navigationController: UINavigationController
}
