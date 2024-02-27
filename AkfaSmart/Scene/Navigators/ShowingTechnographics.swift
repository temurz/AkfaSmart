//
//  ShowingTechnographics.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI


protocol ShowingTechnographics {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingTechnographics {
    func showTechnographics() {
        let view: TechnoGraphicsView = TechnoGraphicsView(viewModel: TechnoGraphicsViewModel(useCase: TechnoGraphicsViewUseCase(gateway: TechnoGraphicsGateway())))
        let vc = UIHostingController(rootView: view)
        self.navigationController.pushViewController(vc, animated: true)
    }
}

