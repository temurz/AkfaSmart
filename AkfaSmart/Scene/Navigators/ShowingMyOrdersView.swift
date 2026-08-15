//
//  ShowingMyOrdersView.swift
//  AkfaSmart
//

import UIKit
import SwiftUI
protocol ShowingMyOrdersView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingMyOrdersView {
    func showMyOrders() {
        let view: MyOrdersView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
