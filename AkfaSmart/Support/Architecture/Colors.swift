//
//  Colors.swift
//  AkfaSmart
//
//  Created by Temur on 09/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct Colors {
    static var textFieldLightGrayBackground = Color(hex: "#FDFDFF")
    static var textFieldMediumGrayBackground = Color(hex: "#F5F7FA")
    
    static var borderGrayColor = Color(hex: "#E7E7E7")
    static var borderGrayColor2 = Color(hex: "#E8EEF4")
    static var blockedGrayTextColor = Color(hex: "#CACACA")
    
    static var buttonBackgroundGrayColor = Color(hex: "#F3F3F3")
    
    static var iconGrayColor = Color(hex: "#A2A5B9")
    
    static var textDescriptionColor = Color(hex: "#313844")
    static var textSteelColor = Color(hex: "#7A889B")
    
    static var customRedColor = Color(hex: "#E32F27")
    
    static var customGreenBackgroundColor = Color(hex: "#72C36A")
    static var customMustardBackgroundColor = Color(hex: "#FFD600")
    
    static var primaryTextColor = Color(hex: "#51526C")
    static var secondaryTextColor = Color(hex: "#9DA8C2")
    
    static var redCardGradientBackground = CardGradient(firstColor: Color(hex: "#E32F27"), secondColor: Color(hex: "#7D1547"))
    static var secondCardGradientBackground = CardGradient(firstColor: Color(hex: "#673AB7"), secondColor: Color(hex: "#331664"))
    static var thirdCardGradientBackground = CardGradient(firstColor: Color(hex: "#FF9800"), secondColor: Color(hex: "#724E18"))
    static var fourthCardGradientBackground = CardGradient(firstColor: Color(hex: "#00BCD4"), secondColor: Color(hex: "#16606A"))
    static var fifthCardGradientBackground = CardGradient(firstColor: Color(hex: "#9C27B0"), secondColor: Color(hex: "#60176D"))
    static var sixthCardGradientBackground = CardGradient(firstColor: Color(hex: "#FF5722"), secondColor: Color(hex: "#782F18"))
    static var seventhCardGradientBackground = CardGradient(firstColor: Color(hex: "#8BC34A"), secondColor: Color(hex: "#456A1B"))
    
    static var redCardGradientHexString = "#E32F27,#7D1547"
    static var secondCardGradientHexString = "#673AB7,#331664"
    static var thirdCardGradientHexString = "#FF9800,#724E18"
    static var fourthCardGradientHexString = "#00BCD4,#16606A"
    static var fifthCardGradientHexString = "#9C27B0,#60176D"
    static var sixthCardGradientHexString = "#FF5722,#782F18"
    static var seventhCardGradientHexString = "#8BC34A,#456A1B"
    
//    "#E32F27,#7D1547",
//    "#673AB7,#331664",
//    "#FF9800,#724E18",
//    "#00BCD4,#16606A",
//    "#9C27B0,#60176D",
//    "#FF5722,#782F18",
//    "#8BC34A,#456A1B"
}

struct CardGradient {
    let firstColor: Color
    let secondColor: Color
}
