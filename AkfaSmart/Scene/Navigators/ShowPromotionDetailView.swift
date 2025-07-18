//
//  ShowPromotionDetailView.swift
//  AkfaSmart
//
//  Created by Temur on 18/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import SwiftUI

protocol ShowPromotionDetailView {
    var navigationController: UINavigationController { get }
    var assembler: Assembler { get }
}

extension ShowPromotionDetailView {
    func showPromotionDetailView(promotion: Promotion) {
        let view: PromotionDetailView = assembler.resolve(promotion: promotion, navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
