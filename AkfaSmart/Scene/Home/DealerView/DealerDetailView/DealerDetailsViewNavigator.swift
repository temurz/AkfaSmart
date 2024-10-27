//
//  DealerDetailsViewNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 27/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol DealerDetailsViewNavigatorType {
    func showPurchasesHistoryView()
    func showPaymentsHistoryView()
    func dismissViewController()
}

struct DealerDetailsViewNavigator: DealerDetailsViewNavigatorType, ShowingPurchasesHistoryView, ShowingPaymentsHistoryView {
    var assembler: Assembler
    
    var navigationController: UINavigationController
    
    func dismissViewController() {
        navigationController.dismiss(animated: true)
    }
}
