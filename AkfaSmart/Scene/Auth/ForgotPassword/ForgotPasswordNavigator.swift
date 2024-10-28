//
//  ForgotPasswordNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 18/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol ForgotPasswordNavigatorType {
    func showCodeInput(reason: CodeReason)
    func popView()
}

struct ForgotPasswordNavigator: ForgotPasswordNavigatorType, ShowingCodeInput, PoppingController {
    let assembler: Assembler
    let navigationController: UINavigationController
}
