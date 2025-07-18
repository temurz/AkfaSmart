//
//  ShowMyCouponsView.swift
//  AkfaSmart
//
//  Created by Temur on 18/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import SwiftUI

protocol ShowMyCouponsView {
    var navigationController: UINavigationController { get }
}

extension ShowMyCouponsView {
    func showMyCouponsView() {
        let view = MyCouponsView(
            viewModel: MyCouponsViewModel(
                useCase: MyCouponsViewUseCase(gateway: GetCouponItemsGateway()),
                navigator: PopViewNavigator(navigationController: navigationController))
        )
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
