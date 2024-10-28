//
//  ShowingAddCardView.swift
//  AkfaSmart
//
//  Created by Temur on 28/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingAddCardView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingAddCardView {
    func showAddCardView() {
        let view: AddCardView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
