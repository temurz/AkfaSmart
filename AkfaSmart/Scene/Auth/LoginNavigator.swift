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
    func showWelcomeView()
    func showForgotPassword()
}

struct LoginNavigator: LoginNavigatorType, ShowingRegistration, ShowingForgotPassword, ShowingWelcomeView {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
