//
//  ShowingTechnicalSupport.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 10/03/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingTechnicalSupportView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingTechnicalSupportView {
    func showTechnicalSupport() {
        let view: TechnicalSupportView = TechnicalSupportView(viewModel: TechnicalSupportViewModel(useCase: TechnicalSupportUseCase(gateway: MessagesGateway())))
        let vc = UIHostingController(rootView: view)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
