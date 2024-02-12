//
//  AddDealerNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol AddDealerNavigatorType {
    func showMain()
}

struct AddDealerNavigator: AddDealerNavigatorType, ShowingMain {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
