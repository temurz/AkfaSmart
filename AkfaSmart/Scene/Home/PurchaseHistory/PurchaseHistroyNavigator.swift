//
//  PurchaseHistroyNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol PurchaseHistoryViewNavigatorType {
    func showDateFilterView(_ dateFilter: DateFilter)
}

struct PurchaseHistoryViewNavigator: PurchaseHistoryViewNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func showDateFilterView(_ dateFilter: DateFilter) {
        let view = DateIntervalView(navigationContoller: navigationController)
            .environmentObject(dateFilter)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
