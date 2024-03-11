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
    func showMain(page: MainPage)
    func showTechnicalSupport()
}

struct HomeViewNavigator: HomeViewNavigatorType, ShowingAddDealerView, ShowingClassDetailView, ShowingPurchasesHistoryView, ShowingPaymentsHistoryView, ShowingMain, ShowingTechnicalSupportView {
    var assembler: Assembler
    
    var navigationController: UINavigationController
}
