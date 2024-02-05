//
//  NewsNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import UIKit
protocol NewsNavigatorType {
    func showDetail(_ item: NewsItemViewModel)
}

struct NewsNavigator: NewsNavigatorType, ShowingNewsDetailView {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}

