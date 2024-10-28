//
//  ShowingSecretgraphics.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingProductGraphics {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingProductGraphics {
    func showProductGraphics() {
        let view: ProductGraphicsView = ProductGraphicsView(
            viewModel: ProductGraphicsViewModel(
                useCase: ProductGraphicsViewUseCase(gateway: ProductGraphicsGateway()),
                navigator: PopViewNavigator(navigationController: navigationController))
        )
        let vc = UIHostingController(rootView: view)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
