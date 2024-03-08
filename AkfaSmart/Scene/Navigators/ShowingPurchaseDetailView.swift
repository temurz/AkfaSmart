//
//  ShowingPurchaseDetailView.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingPurchaseDetailView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingPurchaseDetailView {
    func showPurchaseDetailView(_ model: Invoice) {
        let view: PurchaseDetailView = assembler.resolve(model: model)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
