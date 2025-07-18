//
//  PromotionDetailNavigation.swift
//  AkfaSmart
//
//  Created by Temur on 18/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import UIKit

protocol PromotionDetailNavigatorType {
    func popView()
    func showMyCouponsView()
}

struct PromotionDetailNavigator: PromotionDetailNavigatorType, PoppingController, ShowMyCouponsView {
    unowned var assembler: Assembler
    
    unowned var navigationController: UINavigationController
}
