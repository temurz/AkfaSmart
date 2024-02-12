//
//  LoginNavigator.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//
import UIKit

protocol LoginNavigatorType {
    func showRegistration()
    func showMain()
    func showAddDealerView()
    func showForgotPassword()
}

struct LoginNavigator: LoginNavigatorType, ShowingRegistration, ShowingMain, ShowingForgotPassword, ShowingAddDealerView {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
