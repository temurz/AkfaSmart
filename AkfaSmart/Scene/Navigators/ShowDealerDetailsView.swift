//
//  ShowDealerDetailsView.swift
//  AkfaSmart
//
//  Created by Temur on 27/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowDealerDetailsView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowDealerDetailsView {
    func showDealersDetailViewModally(dealer: Dealer) {
        let view: DealerDetailModalView = assembler.resolve(model: dealer, navigationController: navigationController)
        
        let vc = UIHostingController(rootView: view)
        vc.view.backgroundColor = .clear
        navigationController.present(vc, animated: true)
    }
}
