//
//  TabBarItemView.swift
//  AkfaSmart
//
//  Created by Temur on 01/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct TabBarItemView<Router>: View where Router: ViewRouter{
  
    @StateObject var viewRouter: Router
  
  let tabBarItem: TabBarItem
  let defaultColor: Color
  let selectedColor: Color
  let width, height: CGFloat
  
  let font : Font
  
  private var displayColor: Color {
      selected ? .white : defaultColor
  }
    
    private var displayBackgroundColor: Color {
        selected ? selectedColor : .clear
    }
  
  private var selected: Bool {
      viewRouter.selectedPageId == tabBarItem.id
  }
    
    var body: some View {
        VStack {
//            Spacer()
            Group {
                Image(tabBarItem.imageName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(displayColor)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
                    .background(displayBackgroundColor)
                    .cornerRadius(10)
                    .shadow(color: selected ? selectedColor.opacity(0.5) : .clear, radius: 1, x: 0, y: 1)
                Text(tabBarItem.title)
                    .font(font)
                    .foregroundColor(defaultColor)
            }
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, -4)
            .onTapGesture {
                viewRouter.route(selectedPageId: tabBarItem.id)
            }
    }
}
