//
//  AddCardViewNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 28/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol AddCardViewNavigatorType {
    func popView()
    func showModally(reason: CodeReason, isModal: Bool, completion: ((Bool) -> Void)? )
}

struct AddCardViewNavigator: AddCardViewNavigatorType, PoppingController, ShowingCodeInput {
    var assembler: Assembler
    var navigationController: UINavigationController
}
