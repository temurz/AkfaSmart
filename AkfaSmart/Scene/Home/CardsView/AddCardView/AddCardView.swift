//
//  AddCardView.swift
//  AkfaSmart
//
//  Created by Temur on 28/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct AddCardView: View {
    @ObservedObject var output: AddCardViewModel.Output
    private let popViewControllerTrigger = PassthroughSubject<Void,Never>()
    private let addCardTrigger = PassthroughSubject<Void,Never>()
    let cancelBag = CancelBag()
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "ADD_CARD".localizedString) {
                    popViewControllerTrigger.send(())
                }
                CardsCarousel(data: $output.coloredCards, currentIndex: $output.cardIndex, targetIndex: $output.targetIndex, height: 180)
                    .frame(height: 180)
                coloredButtons
                VStack(alignment: .leading) {
                    ZStack(alignment: .leading) {
                        NumberPhoneMaskView(number: $output.phoneNumber)
                            .frame(height: 50)
                            .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 8))
                            .background(Colors.textFieldLightGrayBackground)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        self.output.phoneNumberValidationMessage.isEmpty ? Colors.borderGrayColor : .red,
                                        lineWidth: self.output.phoneNumberValidationMessage.isEmpty ? 1 : 2)
                            }
                        Image("call")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 16, height: 16)
                            .padding()
                    }
                    
                    Text(self.output.phoneNumberValidationMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                    CustomSecureTextField(placeholder: "CARD_NUMBER".localizedString, password: $output.cardNumber, image: "card_icon", keyboardType: .numberPad)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    self.output.cardNumberValidationMessage.isEmpty ? Colors.borderGrayColor : .red,
                                    lineWidth: self.output.cardNumberValidationMessage.isEmpty ? 1 : 2)
                        }
                    Text(self.output.cardNumberValidationMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                    ZStack(alignment: .leading) {
                        TextField("CARD_NAME".localizedString, text: $output.cardName)
                            .frame(height: 50)
                            .padding(.horizontal)
                            .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 8))
                            .background(Colors.textFieldLightGrayBackground)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        self.output.cardNameValidationMessage.isEmpty ? Colors.borderGrayColor : .red,
                                        lineWidth: self.output.cardNameValidationMessage.isEmpty ? 1 : 2)
                            }
                        Image("card-edit")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 18, height: 18)
                            .padding()
                    }
                    Text(self.output.cardNameValidationMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                    Toggle("MAKE_MAIN_CARD".localizedString, isOn: $output.isMain)
                        .tint(.red)
                        
                    
                }
                .padding()
                Spacer()
                Button {
                    addCardTrigger.send(())
                } label: {
                    Text("ADD_CARD".localizedString)
                        .foregroundStyle(.white)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Colors.customRedColor)
                .cornerRadius(8, corners: .allCorners)
                .padding()
            }
        }
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    init(viewModel: AddCardViewModel) {
        let input = AddCardViewModel.Input(
            popViewControllerTrigger: popViewControllerTrigger.asDriver(), addCardTrigger: addCardTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
    
    var coloredButtons: some View {
        HStack {
            Spacer()
            HStack {
                Button {
                    output.targetIndex = 0
                } label: {
                    Circle()
                        .foregroundStyle(gradient(colors: output.coloredCards[0].getColorStrings().map({ Color(hex:$0) }), startPoint: .bottomLeading, endPoint: .topTrailing))
                        .padding(3)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(output.cardIndex == 0 ? Colors.customMustardBackgroundColor : .clear, lineWidth: 2)
                        }
                }
                Button {
                    output.targetIndex = 1
                } label: {
                    Circle()
                        .foregroundStyle(gradient(colors: output.coloredCards[1].getColorStrings().map({ Color(hex:$0) }), startPoint: .bottomLeading, endPoint: .topTrailing))
                        .padding(3)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(output.cardIndex == 1 ? Colors.customRedColor : .clear, lineWidth: 2)
                        }
                }

                Button {
                    output.targetIndex = 2
                } label: {
                    Circle()
                        .foregroundStyle(gradient(colors: output.coloredCards[2].getColorStrings().map({ Color(hex:$0) }), startPoint: .bottomLeading, endPoint: .topTrailing))
                        .padding(3)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(output.cardIndex == 2 ? Colors.blueCardGradientBackground.firstColor : .clear, lineWidth: 2)
                        }
                }
                    
                Button {
                    output.targetIndex = 3
                } label: {
                    Circle()
                        .foregroundStyle(gradient(colors: output.coloredCards[3].getColorStrings().map({ Color(hex:$0) }), startPoint: .bottomLeading, endPoint: .topTrailing))
                        .padding(3)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(output.cardIndex == 3 ? Colors.purpleCardGradientBackground.firstColor : .clear, lineWidth: 2)
                        }
                }
                
                
            }
            .frame(height: 24)
            Spacer()
        }

    }
}
