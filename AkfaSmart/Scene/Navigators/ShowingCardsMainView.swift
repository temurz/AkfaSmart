//
//  ShowingCardsMainView.swift
//  AkfaSmart
//
//  Created by Temur on 28/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingCardsMainView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingCardsMainView {
    func showCardsMainView() {
        let view: CardsMainView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
