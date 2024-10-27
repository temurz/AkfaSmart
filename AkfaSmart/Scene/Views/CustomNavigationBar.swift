//
//  CustomNavigationBar.swift
//  AkfaSmart
//
//  Created by Temur on 27/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct CustomNavigationBar: View {
    var title: String
    var rightBarTitle: String?
    var rightBarImage: String?
    var onBackTapAction: () -> Void
    var onRightBarButtonTapAction: (() -> Void)?
    
    var body: some View {
        VStack {
            ViewWithShadowOnBottom {
                HStack {
                    ZStack {
                            Text(title)
                                .font(.headline)
                                .foregroundStyle(.black)
                                .padding()
                        HStack {
                            Image("arrow_back")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .onTapGesture {
                                    onBackTapAction()
                                }
                                .padding(.leading)
                            Spacer(minLength: 10)
                            Text(title)
                                .font(.headline)
                                .foregroundStyle(.clear)
                                .padding()
                            Spacer(minLength: 10)
                            if let rightBarImage {
                                Image(rightBarImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(Colors.customRedColor)
                                    .frame(width: 24, height: 24)
                                    .onTapGesture {
                                        onRightBarButtonTapAction?()
                                    }
                                    .padding(8)
                                    .background(Color.white)
                            } else if let rightBarTitle {
                                Text(rightBarTitle)
                                    .foregroundStyle(Colors.customRedColor)
                                    .font(.callout)
                                    .lineLimit(1)
                                    .bold()
                                    .onTapGesture {
                                        onRightBarButtonTapAction?()
                                    }
                                    .padding(.trailing)
                                    .background(Color.white)
                            }
                        }
                    }
                }
            }
        }
        .background(Color.white)
    }
}
