//
//  CardsMainViewNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 28/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol CardsMainViewNavigatorType {
    func popView()
    func showAddCardView()
}

struct CardsMainViewNavigator: CardsMainViewNavigatorType, PoppingController, ShowingAddCardView {
    var assembler: Assembler
    var navigationController: UINavigationController
}

