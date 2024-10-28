//
//  EditInfoGraphicsViewNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 12/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol PopViewNavigatorType {
    func popView()
}

struct PopViewNavigator: PopViewNavigatorType, PoppingController {
    unowned var navigationController: UINavigationController
}
