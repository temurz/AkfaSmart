//
//  NavigateToPreviousController.swift
//  AkfaSmart
//
//  Created by Temur on 27/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol PoppingController {
    var navigationController: UINavigationController { get }
}

extension PoppingController {
    func popView() {
        navigationController.popViewController(animated: true)
    }
}
