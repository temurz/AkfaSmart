//
//  ForgotPasswordView.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct ForgotPasswordView: View {
    @ObservedObject var input: ForgotPasswordViewModel.Input
    @ObservedObject var output: ForgotPasswordViewModel.Output
    private let confirmPhoneNumberTrigger = PassthroughSubject<Void,Never>()
    
    @State var statusBarHeight: CGFloat = 0
    private let cancelBag = CancelBag()
    
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
                .padding(.bottom)
                VStack(alignment: .leading, spacing: 16) {
                    Text("FORGOT_PASSWORD_QUESTION".localizedString)
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)
                    
                    Text("ENTER_PHONE_NUMBER_RESET_PASSWORD".localizedString)
                        .font(.headline)
                        .foregroundColor(Colors.textDescriptionColor)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom)
                    ZStack(alignment: .leading) {
                        NumberPhoneMaskView(number: $input.phoneNumber)
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
                            .frame(width: 18, height: 18)
                            .padding()
                    }
                    Text(output.usernameValidationMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                Spacer()
                Button {
                    confirmPhoneNumberTrigger.send(())
                }label: {
                    Text("CONFIRM".localizedString)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Colors.customRedColor)
                        .cornerRadius(8)
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
    
    init(viewModel: ForgotPasswordViewModel) {
        let input = ForgotPasswordViewModel.Input(confirmPhoneNumberTrigger: confirmPhoneNumberTrigger.asDriver())
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
    
}


struct CustomHeaderView<Content: View>: View {
    @State var statusBarHeight: CGFloat = 0
    
    var content: () -> Content
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea(edges: .top)
            Color.white
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .padding(.top, statusBarHeight > 0 ? statusBarHeight : 48)
                .ignoresSafeArea()
                .onAppear {
                    if let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager {
                        statusBarHeight = statusBarManager.statusBarFrame.height
                    }
                }
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image("akfa_smart")
                        .frame(width: 124, height: 44)
                    Spacer()
                }
                .padding(.bottom)
                
                content()
            }
            .padding()
        }
    }
}
