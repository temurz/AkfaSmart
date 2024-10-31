//
//  EditCardViewNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 31/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
protocol EditCardViewNavigatorType {
    func popView()
    func showModally(reason: CodeReason, isModal: Bool, completion: ((Bool) -> Void)? )
}

struct EditCardViewNavigator: EditCardViewNavigatorType, PoppingController, ShowingCodeInput {
    var assembler: Assembler
    var navigationController: UINavigationController
}
