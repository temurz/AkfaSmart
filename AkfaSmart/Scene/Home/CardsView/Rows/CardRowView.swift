//
//  CardViewRow.swift
//  AkfaSmart
//
//  Created by Temur on 21/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct CardRowView: View {
    var model: Card
    var width: CGFloat
    
    init(model: Card, width: CGFloat = UIScreen.main.bounds.width) {
        self.model = model
        self.width = width
    }
    
    var body: some View {
        VStack {
            VStack {
                if model.id < 0 {
                    HStack {
                        Spacer()
                        Image(systemName: "plus.app")
                            .resizable()
                            .foregroundStyle(Colors.customRedColor)
                            .frame(width: 24, height: 24)
                        Text("ADD_CARD".localizedString)
                            .font(.headline)
                            .foregroundStyle(Colors.customRedColor)
                        Spacer()
                    }
                    .frame(height: 140)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(hex: "#E2E5ED"), lineWidth: 1)
                    }
                } else {
                    ZStack {
                        if model.isBlocked ?? false {
                            gradient(colors: [Color(hex: "#ECECEC"), Color(hex: "#E2E2E2")], startPoint: .bottomLeading, endPoint: .topTrailing)
                        } else {
                            gradient(colors: model.getColorStrings().map({ Color(hex: $0) }), startPoint: .bottomLeading, endPoint: .topTrailing)
                        }
                        
                        HStack {
                            Spacer()
                            Image("transparentIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 140, height: 140)
                        }
                        .padding(.horizontal)
                        VStack {
                            HStack {
                                Text(model.displayName?.uppercased() ?? "BONUS_CARD".localizedString)
                                    .font(.subheadline)
                                    .foregroundStyle(
                                        (model.isBlocked ?? false) ? Colors.blockedGrayTextColor : .white
                                    )
                                Spacer()
                                Image("more_vert")
                                    .renderingMode(.template)
                                    .resizable()
                                    .foregroundStyle(.white)
                                    .frame(width: 24, height: 24)
                            }
                            .padding([.top, .horizontal])
                            HStack {
                                Text((model.balance?.convertDecimals() ?? "0") + " uzs")
                                    .bold()
                                    .font(.title3)
                                    .foregroundStyle(
                                        (model.isBlocked ?? false) ? Colors.blockedGrayTextColor : .white
                                    )
                                    .padding(.horizontal)
                                    .padding(.vertical, 4)
                                Spacer()
                            }
                            
                            Spacer()
                            HStack(spacing: 4) {
                                Text(model.cardNumber?.addSpaces(byEvery: 3) ?? "000 000 000 000")
                                    .foregroundStyle(
                                        (model.isBlocked ?? false) ? Colors.blockedGrayTextColor : .white
                                    )
                                    .font(.subheadline)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical,4)
                                    .background(Color.white.opacity(0.18))
                                    .cornerRadius(6, corners: .allCorners)
                                Spacer()
                                if model.isMain ?? false {
                                    Text("MAIN".localizedString)
                                        .font(.footnote)
                                        .bold()
                                        .foregroundStyle(
                                            (model.isBlocked ?? false) ? Colors.blockedGrayTextColor : .white
                                        )
                                        .padding(.horizontal, 8)
                                        .padding(.vertical,4)
                                        .background(
                                            (model.isBlocked ?? false) ? Colors.buttonBackgroundGrayColor: Colors.customMustardBackgroundColor
                                        )
                                        .cornerRadius(5, corners: .allCorners)
                                }
                                Text("ACTIVE".localizedString)
                                    .font(.footnote)
                                    .bold()
                                    .foregroundStyle(
                                        (model.isBlocked ?? false) ? Colors.blockedGrayTextColor : .white
                                    )
                                    .padding(.horizontal, 8)
                                    .padding(.vertical,4)
                                    .background(
                                        (model.isBlocked ?? false) ? Colors.buttonBackgroundGrayColor :  Colors.customGreenBackgroundColor
                                    )
                                    .cornerRadius(5, corners: .allCorners)
                            }
                            .padding()
                        }
                        if model.isBlocked ?? false {
                            Color.gray.opacity(0.2)
                            VStack {
                                HStack {
                                    Image("lock_1")
                                        .renderingMode(.template)
                                        .resizable()
                                        .foregroundStyle(.white)
                                        .frame(width: 16, height: 16)
                                    Text("BLOCKED".localizedString)
                                        .font(.subheadline)
                                        .foregroundStyle(.white)
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal)
                                .background(Colors.customRedColor)
                                .cornerRadius(8, corners: .allCorners)
                            }
                        }
                    }
                    .cornerRadius(12, corners: .allCorners)
                    
                }
                
            }
            .frame(height: 140)
            .padding(.horizontal)
            
        }
        .frame(height: 140)
        .frame(width: width)
    }
}
