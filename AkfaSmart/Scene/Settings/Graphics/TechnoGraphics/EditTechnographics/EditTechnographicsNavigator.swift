//
//  EditTechnographicsNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol EditTechnographicsNavigatorType {
    func popView()
    func openMap(_ manager: LocationInfoManager)
}

struct EditTechnographicsNavigator: EditTechnographicsNavigatorType {
    unowned var navigationController: UINavigationController
    
    func popView() {
        navigationController.popViewController(animated: true)
    }
    
    func openMap(_ manager: LocationInfoManager) {
        let view = MapView(navigationController: navigationController)
            .environmentObject(manager)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
