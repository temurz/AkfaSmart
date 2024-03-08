//
//  ShowingPaymentsHistoryView.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingPaymentsHistoryView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingPaymentsHistoryView {
    func showPaymentsHistoryView() {
        let view: PaymentHistoryView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
