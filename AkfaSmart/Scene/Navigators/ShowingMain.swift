//
//  ShowingMain.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import SwiftUI
protocol ShowingMain {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingMain {
    func showMain(page: MainPage) {
        let view: MainView = assembler.resolve(navigationController: navigationController, page: page)
        
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: true)
    }
}
