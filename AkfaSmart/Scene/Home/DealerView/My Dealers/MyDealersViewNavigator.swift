//
//  MyDealersViewNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 01/12/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol MyDealersViewNavigatorType {
    func popView()
    func showDealersDetailViewModally(dealer: Dealer)
    func showAddDealerView()
}

struct MyDealersViewNavigator: MyDealersViewNavigatorType, PoppingController, ShowDealerDetailsView, ShowingAddDealerView {
    var assembler: Assembler
    
    var navigationController: UINavigationController

}
