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
    func showCoupons()
}

struct PromotionDetailNavigator: PromotionDetailNavigatorType, PoppingController {
    func showCoupons() {
        
    }
    
    unowned var navigationController: UINavigationController
}
