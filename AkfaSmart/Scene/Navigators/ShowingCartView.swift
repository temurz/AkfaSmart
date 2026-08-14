//
//  ShowingCartView.swift
//  AkfaSmart
//

import UIKit
import SwiftUI
protocol ShowingCartView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingCartView {
    func showCartView() {
        let view: CartView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
