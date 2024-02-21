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
            CustomHeaderView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Reset password")
                        .font(.title)
                    Text("Create a new password")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    CustomSecureTextField(placeholder: "New password",
                                          password: $output.password)
                    Text(output.passwordValidationMessage)
                        .font(.footnote)
                        .foregroundColor(.red)
                    CustomSecureTextField(placeholder: "Confirm new password",
                        password: $output.repeatedPassword)
                    Text(output.repeatedPasswordValidationMessage)
                        .font(.footnote)
                        .foregroundColor(.red)
                    Spacer()
                    Button {
                        resetPasswordTrigger.send(())
                    } label: {
                        Text("Reset password")
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
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
