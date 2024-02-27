//
//  ShowingHRgraphics.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingHRgraphics {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingHRgraphics {
    func showHRgraphics() {
        let view: HRgraphicsView = HRgraphicsView(viewModel: HRgraphicsViewModel(useCase: HRGraphicsViewUseCase(gateway: HRGateway())))
        let vc = UIHostingController(rootView: view)
        self.navigationController.pushViewController(vc, animated: true)
    }
}

