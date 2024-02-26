//
//  ShowingArticleDetail.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ShowingArticleDetail {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingArticleDetail {
    func showArticleDetail(_ item: ArticleItemViewModel) {
        let view: ArticleDetailView = ArticleDetailView(itemModel: item)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}

