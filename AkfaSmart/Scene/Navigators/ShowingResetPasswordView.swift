//
//  ShowingResetPasswordView.swift
//  AkfaSmart
//
//  Created by Temur on 21/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingResetPasswordView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingResetPasswordView {
    func showResetPasswordView() {
        let view: ResetPasswordView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
