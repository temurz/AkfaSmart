//
//  ArticlesNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol ArticlesNavigatorType {
    func showArticleDetail(_ item: ArticleItemViewModel)
    func showArticlesFilterView(_ dateFilter: DateFilter, _ type: ArticleObservableType)
}

struct ArticlesNavigator: ArticlesNavigatorType, ShowingArticleDetail {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func showArticlesFilterView(_ dateFilter: DateFilter, _ type: ArticleObservableType) {
        let viewModel: ArticlesFilterViewModel = assembler.resolve()
        let view = ArticlesFilterView(viewModel: viewModel, navigationController: navigationController)
            .environmentObject(dateFilter)
            .environmentObject(type)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}

class ArticleObservableType: ObservableObject {
    @Published var type: String? = nil
}
