//
//  CodeInputNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol CodeInputNavigatorType {
    func showMain(page: MainPage)
    func showResetPasswordView()
    func showPINCodeView(state: PINCodeState)
    func popView()
}

struct CodeInputNavigator: CodeInputNavigatorType, ShowingMain, ShowingResetPasswordView, ShowingPINCodeView, PoppingController {
    unowned var assembler: Assembler
    unowned var navigationController: UINavigationController
}
