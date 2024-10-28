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
                        gradient(colors: model.getColorStrings().map({ Color(hex: $0) }), startPoint: .bottomLeading, endPoint: .topTrailing)
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
                                Text("BONUS_CARD".localizedString)
                                    .font(.subheadline)
                                    .foregroundStyle(Color.white)
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
                                    .foregroundStyle(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 4)
                                Spacer()
                            }
                            
                            Spacer()
                            HStack(spacing: 4) {
                                Text(model.cardNumber?.addSpaces(byEvery: 3) ?? "xxx xxx xxx xxx")
                                    .foregroundStyle(.white)
                                    .font(.subheadline)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical,4)
                                    .background(Color.white.opacity(0.18))
                                    .cornerRadius(6, corners: .allCorners)
                                Spacer()
                                if model.isMain ?? false {
                                    Text("MAIN".localizedString)
                                        .font(.footnote)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical,4)
                                        .background(Colors.customMustardBackgroundColor)
                                        .cornerRadius(5, corners: .allCorners)
                                }
                                Text("ACTIVE".localizedString)
                                    .font(.footnote)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical,4)
                                    .background(Colors.customGreenBackgroundColor)
                                    .cornerRadius(5, corners: .allCorners)
                            }
                            .padding()
                        }
                    }
                    .cornerRadius(12, corners: .allCorners)
                    
                }
                
            }
            .frame(height: 140)
            .padding(.horizontal)
            
        }
        .frame(height: 140)
        .frame(width: UIScreen.main.bounds.width)
    }
}
