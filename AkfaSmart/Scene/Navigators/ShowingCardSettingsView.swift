//
//  ShowingCardSettingsView.swift
//  AkfaSmart
//
//  Created by Temur on 31/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingCardSettingsView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingCardSettingsView {
    func showCardSettingsView(_ card: Card) {
        let view: EditCardView = assembler.resolve(model: card, navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
