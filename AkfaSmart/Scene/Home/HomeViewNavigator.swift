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
    func showClassDetailView(imageData: Data?, title: String?)
    func showPurchasesHistoryView()
    func showPaymentsHistoryView()
}

struct HomeViewNavigator: HomeViewNavigatorType, ShowingAddDealerView, ShowingClassDetailView, ShowingPurchasesHistoryView, ShowingPaymentsHistoryView {
    var assembler: Assembler
    
    var navigationController: UINavigationController
}
