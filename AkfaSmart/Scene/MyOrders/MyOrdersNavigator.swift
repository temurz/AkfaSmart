//
//  MyOrdersNavigator.swift
//  AkfaSmart
//

import UIKit
import SwiftUI
protocol MyOrdersViewNavigatorType {
    func popView()
    func showOrderDetailView(_ model: OrderSummary)
}

struct MyOrdersViewNavigator: MyOrdersViewNavigatorType, PoppingController {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController

    func showOrderDetailView(_ model: OrderSummary) {
        let view: MyOrderDetailView = assembler.resolve(model: model, navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
