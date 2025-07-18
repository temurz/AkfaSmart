//
//  PromotionsListNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 18/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import UIKit

protocol PromotionsListNavigatorType {
    func popView()
    func showPromotionDetailView(promotion: Promotion)
}

struct PromotionsListNavigator: PromotionsListNavigatorType, PoppingController, ShowPromotionDetailView {
    var navigationController: UINavigationController
    
    var assembler: Assembler
}
