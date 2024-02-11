//
//  SettingsNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol SettingsNavigatorType {
    func showLogin()
}

struct SettingsNavigator: SettingsNavigatorType, ShowingLogin {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
