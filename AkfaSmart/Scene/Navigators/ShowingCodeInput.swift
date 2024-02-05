//
//  ShowingCodeInput.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingCodeInput {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingCodeInput {
    func showCodeInput(title: String) {
        let view: CodeInputView = assembler.resolve(navigationController: navigationController, title: title)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
