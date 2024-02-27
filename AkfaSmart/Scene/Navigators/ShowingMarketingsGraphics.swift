//
//  ShowingMarketinggraphics.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingMarketinggraphics {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingMarketinggraphics {
    func showMarketinggraphics() {
        let view: MarketingGraphicsView = MarketingGraphicsView(viewModel: MarketingGraphicsViewModel(useCase: MarketingGraphicsViewUseCase(gateway: MarketingGraphicsGateway())))
        let vc = UIHostingController(rootView: view)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
