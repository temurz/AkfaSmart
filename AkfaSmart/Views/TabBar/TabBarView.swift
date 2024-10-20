//
//  TabBarView.swift
//  AkfaSmart
//
//  Created by Temur on 01/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

extension Color {
    static let tabBarColor = Color("tabBarColor")
    
    static let tabBarItemDefaultTintColor = Color.gray
    
    static let tabBarItemSelectedTintColor = Color.red
}

extension Font {
    static func nunitoBold(size: Double) -> Font {
        return Font.custom("Nunito-Bold", size: CGFloat(size))
    }
}


struct TabBarView<Router>: View where Router: ViewRouter {
    
    @StateObject var viewRouter: Router
    
    private let cornerRadius: CGFloat = 16
    private let height: CGFloat = 120
    private let shadowRadius: CGFloat = 16
    
    private let prominentItemWidth: CGFloat = 70
    
    private var prominentItemTopPadding: CGFloat {
        return -prominentItemWidth
    }
    
    let prominentItemImageName: String
    let prominentItemAction: () -> Void
    
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 8) {
                Spacer()
                    ForEach(0..<3) { idx in
                        TabBarItemView(viewRouter: viewRouter,
                                       tabBarItem: self.viewRouter.pages[idx],
                                       defaultColor: .tabBarItemDefaultTintColor,
                                       selectedColor: .tabBarItemSelectedTintColor,
                                       width: 32,
                                       height: 32,
                                       font: .caption2)
                            .frame(width: geo.size.width/6)
                    }
            
                

                if !prominentItemImageName.isEmpty {
                    ProminentTabBarItemView(width: geo.size.width/5.5, systemImageName: prominentItemImageName, action: prominentItemAction)
                        .offset(y: -geo.size.height/8/2-geo.size.width/6/2)
                }
                
                ForEach(3..<self.viewRouter.pages.count) { idx in
                    TabBarItemView(viewRouter: viewRouter,
                                   tabBarItem: self.viewRouter.pages[idx],
                                   defaultColor: .tabBarItemDefaultTintColor,
                                   selectedColor: .tabBarItemSelectedTintColor,
                                   width: 32,
                                   height: 32,
                                   font: .caption2)
                    .frame(width: geo.size.width/6)
                }
                Spacer()
                
            }
        }
    }
    
   
}
