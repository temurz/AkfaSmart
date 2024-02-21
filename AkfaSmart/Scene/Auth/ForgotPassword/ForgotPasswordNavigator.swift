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
}

struct ForgotPasswordNavigator: ForgotPasswordNavigatorType, ShowingCodeInput {
    let assembler: Assembler
    let navigationController: UINavigationController
}
