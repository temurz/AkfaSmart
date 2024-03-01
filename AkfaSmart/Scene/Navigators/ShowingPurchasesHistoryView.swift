//
//  ShowingPurchasesHistoryView.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingPurchasesHistoryView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingPurchasesHistoryView {
    func showPurchasesHistoryView() {
        let view: PurchaseHistoryView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
