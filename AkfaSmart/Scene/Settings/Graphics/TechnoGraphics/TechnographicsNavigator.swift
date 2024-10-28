//
//  TechnographicsNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol TechnographicsNavigatorType {
    func showEditTechnographicsView(model: TechnoGraphics)
    func popView()
}

struct TechnographicsNavigator: TechnographicsNavigatorType, ShowingEditTechnographicsView, PoppingController {
    unowned var assembler: Assembler
    unowned var navigationController: UINavigationController
}
