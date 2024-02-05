//
//  ArticlesNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol ArticlesNavigatorType {
    func showArticleDetail(_ item: ArticleItemViewModel)
}

struct ArticlesNavigator: ArticlesNavigatorType, ShowingArticleDetail {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
