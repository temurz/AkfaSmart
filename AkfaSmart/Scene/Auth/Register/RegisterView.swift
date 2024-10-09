//
//  RegisterView.swift
//  AkfaSmart
//
//  Created by Temur on 27/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct RegisterView: View {
    @ObservedObject var input: RegisterViewModel.Input
    @ObservedObject var output: RegisterViewModel.Output
    
    private let cancelBag = CancelBag()
    private let registerTrigger = PassthroughSubject<Void, Never>()
    private let showLoginTrigger = PassthroughSubject<Void,Never>()
    
    var body: some View {
        LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image("akfa_smart")
                        .frame(width: 124, height: 44)
                    Spacer()
                }
                .ignoresSafeArea()
                Group {
                    HStack {
                        Spacer()
                        Text("REGISTER".localizedString)
                            .font(.title)
                            .bold()
                            .padding(.top, 16)
                        Spacer()
                    }
                    
                    ZStack(alignment: .leading) {
                        NumberPhoneMaskView(number: $input.username)
                            .frame(height: 50)
                            .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 8))
                            .background(Colors.textFieldLightGrayBackground)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        self.output.usernameValidationMessage.isEmpty ? Colors.borderGrayColor : .red,
                                        lineWidth: self.output.usernameValidationMessage.isEmpty ? 1 : 2)
                            }
                        Image("call")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 16, height: 16)
                            .padding()
                    }
                    Text(self.output.usernameValidationMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                    CustomSecureTextField(password: $input.password)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    self.output.passwordValidationMessage.isEmpty ? Colors.borderGrayColor : .red,
                                    lineWidth: self.output.passwordValidationMessage.isEmpty ? 1 : 2)
                        }
                    Text(self.output.passwordValidationMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                    CustomSecureTextField(placeholder: "CONFIRM_PASSWORD".localizedString, password: $input.repeatedPassword)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    self.output.repeatedPasswordValidationMessage.isEmpty ? Colors.borderGrayColor : .red,
                                    lineWidth: self.output.repeatedPasswordValidationMessage.isEmpty ? 1 : 2)
                        }
                    Text(self.output.repeatedPasswordValidationMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                    
                    Button {
                        self.registerTrigger.send(())
                    } label: {
                        Text("REGISTER".localizedString)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(Color.white)
                            .background(Colors.customRedColor)
                            .disabled(!self.output.isRegisterEnabled)
                            .cornerRadius(8)
                    }
                    .padding(.top, 16)
                    Button {
                        self.showLoginTrigger.send(Void())
                    } label: {
                        Text("ALREADY_REGISTERED".localizedString)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(Color.black)
                            .background(Colors.buttonBackgroundGrayColor)
                            .cornerRadius(8)
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal, 16)
                Spacer()
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
    
    init(viewModel: RegisterViewModel) {
        let input = RegisterViewModel.Input(registerTrigger: registerTrigger.asDriver(), showLoginTrigger: showLoginTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}

struct RegisterView_Preview: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
