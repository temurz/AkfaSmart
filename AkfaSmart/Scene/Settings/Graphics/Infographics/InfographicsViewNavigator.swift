//
//  InfographicsViewNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 12/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol InfographicsViewNavigatorType {
    func showEditInfographicsView(model: Infographics)
}

struct InfographicsViewNavigator: InfographicsViewNavigatorType, ShowingEditInfographicsView {
    unowned var assembler: Assembler
    unowned var navigationController: UINavigationController
}
