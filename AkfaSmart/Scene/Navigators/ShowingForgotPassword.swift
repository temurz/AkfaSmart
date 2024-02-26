//
//  ShowingForgotPassword.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
protocol ShowingForgotPassword {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingForgotPassword {
    func showForgotPassword() {
        let view: ForgotPasswordView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
