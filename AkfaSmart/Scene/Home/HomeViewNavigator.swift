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
    func showMain(page: MainPage)
    func showTechnicalSupport()
    func showDealersDetailViewModally(dealer: Dealer)
    func showCardsMainView()
}

struct HomeViewNavigator: HomeViewNavigatorType, ShowingAddDealerView, ShowingClassDetailView, ShowingMain, ShowingTechnicalSupportView, ShowDealerDetailsView, ShowingCardsMainView {
    var assembler: Assembler
    
    var navigationController: UINavigationController
}
