//
//  ShowingNewsDetailView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
protocol ShowingNewsDetailView {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingNewsDetailView {
    func showDetail(_ item: NewsItemViewModel) {
        let view: NewsDetailView = NewsDetailView(viewModel: item)
        let vc = UIHostingController(rootView: view)
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }
}
