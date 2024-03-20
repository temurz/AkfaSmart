//
//  SettingsNavigator.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI
protocol SettingsNavigatorType {
    func showLogin()
    func showInfographics()
    func showHRgraphics()
    func showTechnographics()
    func showMarketinggraphics()
    func showProductGraphics()
    func showLanguageChanger()
    func showTechnicalSupport()
    func showPINCodeView(state: PINCodeState)
}

struct SettingsNavigator: 
    SettingsNavigatorType,
    ShowingLogin,
    ShowingInfograpics,
    ShowingHRgraphics,
    ShowingTechnographics,
    ShowingMarketinggraphics,
    ShowingProductGraphics,
    ShowingLanguageChanger,
    ShowingTechnicalSupportView,
    ShowingPINCodeView
{
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
