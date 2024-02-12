//
//  WelcomeViewNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol WelcomeViewNavigatorType {
    func showAddDealerView()
}

struct WelcomeViewNavigator: WelcomeViewNavigatorType, ShowingAddDealerView {
    var assembler: Assembler
    var navigationController: UINavigationController
}
