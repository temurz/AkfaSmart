//
//  ShowingInfograpichs.swift
//  AkfaSmart
//
//  Created by Temur on 11/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingInfographics {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingInfographics {
    func showInfographics() {
        let view: InfographicsView = InfographicsView(viewModel: InfographicsViewModel())
        let vc = UIHostingController(rootView: view)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
