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
    var assembler: Assembler { get }
}

extension ShowMyCouponsView {
    func showMyCouponsView() {
        let view: MyCouponsView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
