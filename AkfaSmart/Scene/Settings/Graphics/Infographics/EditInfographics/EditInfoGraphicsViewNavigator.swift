//
//  EditInfoGraphicsViewNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 12/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol EditInfoGraphicsViewNavigatorType {
    func popView()
}

struct EditInfoGraphicsViewNavigator: EditInfoGraphicsViewNavigatorType {
    unowned var navigationController: UINavigationController
    
    func popView() {
        navigationController.popViewController(animated: true)
    }
}
