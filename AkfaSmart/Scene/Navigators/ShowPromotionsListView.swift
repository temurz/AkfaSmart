//
//  ShowPromotionsListView.swift
//  AkfaSmart
//
//  Created by Temur on 18/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import SwiftUI

protocol ShowPromotionsListView {
    var navigationController: UINavigationController { get }
    var assembler: Assembler { get }
}

extension ShowPromotionsListView {
    func showPromotionsListView(promotions: [Promotion]) {
        let view: PromotionsListView = assembler.resolve(promotions: promotions, navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
