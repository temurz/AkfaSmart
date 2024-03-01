//
//  CreateOrderNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 06/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol SearchProductViewNavigatorType {
    func showProductDealersListView(model: ProductWithName)
}

struct SearchProductViewNavigator: SearchProductViewNavigatorType, ShowingProductDealersListView {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
