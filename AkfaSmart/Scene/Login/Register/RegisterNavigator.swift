//
//  RegisterNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 27/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit

protocol RegisterNavigatorType {
    func showLogin()
    func showCodeInput(title: String)
}

struct RegisterNavigator: RegisterNavigatorType, ShowingLogin, ShowingCodeInput {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
