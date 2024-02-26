//
//  ShowingSecretgraphics.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingSecretgraphics {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingSecretgraphics {
    func showSecretgraphics() {
        let view: SecretgraphicsView = SecretgraphicsView(viewModel: SecretgraphicsViewModel())
        let vc = UIHostingController(rootView: view)
        self.navigationController.pushViewController(vc, animated: true)
    }
}

