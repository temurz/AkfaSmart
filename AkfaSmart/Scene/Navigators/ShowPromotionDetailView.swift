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
}

extension ShowPromotionDetailView {
    func showPromotionDetailView(promotion: Promotion) {
        let view: PromotionDetailView = PromotionDetailView(viewModel: PromotionDetailViewModel(promotion: promotion, navigator: PromotionDetailNavigator(navigationController: navigationController)))
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
