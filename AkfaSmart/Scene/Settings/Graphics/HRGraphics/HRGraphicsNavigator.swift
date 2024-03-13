//
//  HRGraphicsNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol HRGraphicsNavigatorType {
    func showHRGraphicsEditView(_ model: HRGraphics)
}

struct HRGraphicsNavigator: HRGraphicsNavigatorType, ShowingHRGraphicsEditView {
    unowned var assembler: Assembler
    unowned var navigationController: UINavigationController
}
