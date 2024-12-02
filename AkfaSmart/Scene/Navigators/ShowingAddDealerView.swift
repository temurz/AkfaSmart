//
//  ShowingAddDealerView.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingAddDealerView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingAddDealerView {
    func showAddDealerView() {
        let view: AddDealerView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        self.navigationController.present(vc, animated: true)
    }
}
