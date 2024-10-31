//
//  ShowingCodeInput.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
enum CodeReason {
    case register
    case forgotPassword
    case dealer(_ dealer: AddDealer, activeUsername: String?, isActive: Bool)
    case cardActivation(_ cardNumber: String)
    case block(_ id: Int)
    case unblock(_ id: Int, connectedPhone: String)
}

protocol ShowingCodeInput {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingCodeInput {
    func showCodeInput(reason: CodeReason) {
        let view: CodeInputView = assembler.resolve(navigationController: navigationController, reason: reason)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showModally(reason: CodeReason, isModal: Bool, completion: ((Bool) -> Void)? ) {
        let view: CodeInputView = assembler.resolve(navigationController: navigationController, reason: reason, isModal: isModal, completion: completion)
        let vc = UIHostingController(rootView: view)
        navigationController.present(vc, animated: true)
    }
}
