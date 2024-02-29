//
//  ShowingClassDetailView.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingClassDetailView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingClassDetailView {
    func showClassDetailView(imageData: Data?, title: String?) {
        let view: UserClassDetailView = assembler.resolve(imageData: imageData, title: title)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}

