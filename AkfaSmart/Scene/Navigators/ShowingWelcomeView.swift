//
//  ShowingWelcomeView.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingWelcomeView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingWelcomeView {
    func showWelcomeView() {
        let view: WelcomeView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: true)
    }
}
