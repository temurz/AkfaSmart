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
    func showPINCodeView(state: PINCodeState)
}

struct LoginNavigator: LoginNavigatorType, ShowingRegistration, ShowingForgotPassword, ShowingWelcomeView, ShowingPINCodeView {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
