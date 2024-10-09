//
//  ResetPasswordView.swift
//  AkfaSmart
//
//  Created by Temur on 21/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct ResetPasswordView: View {
    @ObservedObject var output: ResetPasswordViewModel.Output
    let resetPasswordTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack(alignment: .leading, spacing: 12) {
                Text("RESET_PASSWORD".localizedString)
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("CREATE_PASSWORD".localizedString)
                    .font(.headline)
                    .foregroundColor(Colors.textDescriptionColor)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                CustomSecureTextField(placeholder: "NEW_PASSWORD".localizedString,
                                      password: $output.password)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(self.output.passwordValidationMessage.isEmpty ? Colors.borderGrayColor : .red, lineWidth: self.output.passwordValidationMessage.isEmpty ? 1 : 2)
                }
                Text(output.passwordValidationMessage)
                    .font(.footnote)
                    .foregroundColor(.red)
                CustomSecureTextField(placeholder: "CONFIRM_NEW_PASSWORD".localizedString,
                                      password: $output.repeatedPassword)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(self.output.repeatedPasswordValidationMessage.isEmpty ? Colors.borderGrayColor : .red, lineWidth: self.output.repeatedPasswordValidationMessage.isEmpty ? 1 : 2)
                }
                Text(output.repeatedPasswordValidationMessage)
                    .font(.footnote)
                    .foregroundColor(.red)
                Spacer()
                Button {
                    resetPasswordTrigger.send(())
                } label: {
                    Text("RESET_PASSWORD".localizedString)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .alert(isPresented: $output.alert.isShowing) {
            Alert(title: Text(output.alert.title),
                  message: Text(output.alert.message),
                  dismissButton: .default(Text("OK"))
            )
        }
        
    }
    
    init(viewModel: ResetPasswordViewModel) {
        let input = ResetPasswordViewModel.Input(resetPasswordTrigger: resetPasswordTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
