//
//  ShowingPINCodeView.swift
//  AkfaSmart
//
//  Created by Temur on 20/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingPINCodeView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingPINCodeView {
    func showPINCodeView(state: PINCodeState) {
        let view: PINCodeView = assembler.resolve(state: state, navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.isNavigationBarHidden = true
        switch state {
        case .onAuth, .enterSimple:
            navigationController.setViewControllers([vc], animated: true)
        default:
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
