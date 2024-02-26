//
//  HomeViewNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol HomeViewNavigatorType {
    func showAddDealerView()
}

struct HomeViewNavigator: HomeViewNavigatorType, ShowingAddDealerView {
    var assembler: Assembler
    
    var navigationController: UINavigationController
}
