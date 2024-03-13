//
//  ShowingEditInfographicsView.swift
//  AkfaSmart
//
//  Created by Temur on 12/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingEditInfographicsView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingEditInfographicsView {
    func showEditInfographicsView(model: Infographics) {
        let view: EditInfographicsView = assembler.resolve(navigationController: navigationController, model: model)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
