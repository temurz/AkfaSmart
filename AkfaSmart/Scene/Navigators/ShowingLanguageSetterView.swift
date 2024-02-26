//
//  ShowingLanguageChanger.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 16/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingLanguageChanger {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingLanguageChanger {
    func showLanguageChanger() {
        let view: LanguageChangerView = LanguageChangerView(viewModel: LanguageChangerViewModel())
        let vc = UIHostingController(rootView: view)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
