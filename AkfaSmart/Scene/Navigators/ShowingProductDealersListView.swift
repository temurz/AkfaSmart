//
//  ShowingProductDealersListView.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingProductDealersListView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingProductDealersListView {
    func showProductDealersListView(model: ProductWithName) {
        let view: ProductDealersListView = assembler.resolve(model: model, navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
