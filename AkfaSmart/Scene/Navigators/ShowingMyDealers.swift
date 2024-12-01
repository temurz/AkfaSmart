//
//  ShowingMyDealers.swift
//  AkfaSmart
//
//  Created by Temur on 01/12/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
protocol ShowingMyDealers {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingMyDealers {
    func showMyDealers(_ dealers: [Dealer]) {
        let view: MyDealersView = assembler.resolve(dealers: dealers, navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
