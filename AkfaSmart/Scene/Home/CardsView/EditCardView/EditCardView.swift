//
//  EditCardView.swift
//  AkfaSmart
//
//  Created by Temur on 31/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct EditCardView: View {
    @ObservedObject var output: EditCardViewModel.Output
    private let cancelBag = CancelBag()
    private let popViewControllerTrigger = PassthroughSubject<Void, Never>()
    private let blockCardTrigger = PassthroughSubject<Void, Never>()
    private let deleteCardTrigger = PassthroughSubject<Void, Never>()
    private let getCardInfoTrigger = PassthroughSubject<Void, Never>()
    private let saveChangesTrigger = PassthroughSubject<Void, Never>()
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "EDIT_CARD_TITLE".localizedString) {
                    popViewControllerTrigger.send(())
                }
                CardRowView(model: output.card)
                VStack(spacing: 16) {
                    Toggle("MAKE_MAIN_CARD".localizedString, isOn: $output.isMain)
                        .tint(.red)
                    VStack {
                        HStack {
                            Text("CARD_NAME".localizedString)
                                .font(.footnote)
                                .foregroundStyle(Colors.primaryTextColor)
                            Spacer()
                        }
                        TextField("CARD_NAME".localizedString, text: $output.cardName)
                            .frame(height: 50)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                            .background(Colors.textFieldLightGrayBackground)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        self.output.cardNameValidationMessage.isEmpty ? Colors.borderGrayColor : .red,
                                        lineWidth: self.output.cardNameValidationMessage.isEmpty ? 1 : 2)
                                
                            }
                        Text(output.cardNameValidationMessage)
                            .font(.footnote)
                            .foregroundStyle(Colors.customRedColor)
                    }
                    Button {
                        saveChangesTrigger.send(())
                    } label: {
                        HStack {
                            Spacer()
                            Text("SAVE".localizedString)
                                .foregroundStyle(Colors.customRedColor)
                            Spacer()
                        }
                    }
                    .frame(height: 50)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Colors.customRedColor)
                    }
                    
                    Spacer()
                    
                    Button {
                        getCardInfoTrigger.send(())
                    } label: {
                        EditCardActionRow(text: "CARD_INFORMATION".localizedString, imageName: "arrow_right")
                    }
                    Button {
                        blockCardTrigger.send(())
                    } label: {
                        EditCardActionRow(text: (output.card.isBlocked ?? false) ? "UNBLOCK_CARD".localizedString : "BLOCK_CARD".localizedString, imageName: "block")
                    }
                    Button {
                        deleteCardTrigger.send(())
                    } label: {
                        EditCardActionRow(text: "DELETE_CARD".localizedString, imageName: "trash_1")
                    }
                }
                .padding()
            }
            .alert(isPresented: $output.alert.isShowing) {
                Alert(
                    title: Text(output.alert.title),
                    message: Text(output.alert.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        
    }
    
    init(viewModel: EditCardViewModel) {
        let input = EditCardViewModel.Input(
            blockCardTrigger: blockCardTrigger.asDriver(),
            saveChangesTrigger: saveChangesTrigger.asDriver(),
            deleteCardTrigger: deleteCardTrigger.asDriver(),
            getCardInfoTrigger: getCardInfoTrigger.asDriver(),
            popViewControllerTrigger: popViewControllerTrigger.asDriver()
        )
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

struct EditCardActionRow: View {
    var text: String
    var imageName: String
    var body: some View {
        VStack {
            HStack {
                Text(text)
                    .font(.subheadline)
                    .foregroundStyle(Colors.primaryTextColor)
                    .padding(.horizontal)
                Spacer()
                Image(imageName)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(Colors.customRedColor)
                    .frame(width: 20, height: 20)
                    .padding(.horizontal)
            }
        }
        .frame(height: 50)
        .padding(.horizontal)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Colors.borderGrayColor)
        }
    }
}
