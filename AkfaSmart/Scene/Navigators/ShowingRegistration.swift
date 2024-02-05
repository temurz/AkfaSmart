//
//  ShowingRegistration.swift
//  AkfaSmart
//
//  Created by Temur on 27/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingRegistration {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingRegistration {
    func showRegistration() {
        let view: RegisterView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
//        let windowScene = UIApplication.shared.windows.first?.windowScene
//        let window = windowScene?.windows.first
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
    }
}
