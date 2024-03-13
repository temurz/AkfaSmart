//
//  ShowingHRGraphicsEditView.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingHRGraphicsEditView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingHRGraphicsEditView {
    func showHRGraphicsEditView(_ model: HRGraphics) {
        let view: HRGraphicsEditView = assembler.resolve(navigationController: navigationController, model: model)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}
