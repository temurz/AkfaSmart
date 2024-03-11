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
    @State private var statusBarHeight: CGFloat = 0
    
    private let cancelBag = CancelBag()
    private let registerTrigger = PassthroughSubject<Void, Never>()
    private let showLoginTrigger = PassthroughSubject<Void,Never>()
    
    var body: some View {
        LoadingView(isShowing: $output.isLoading, text: .constant("")) {
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
                    .ignoresSafeArea()
                    Group {
                        Text("REGISTER".localizedString)
                            .font(.title)
                            .padding(.top, 16)
                        ZStack(alignment: .leading) {
                            NumberPhoneMaskView(number: $input.username)
                                .frame(height: 48)
                                .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 8))
                                .background(Color(hex: "#F5F7FA"))
                                .cornerRadius(12)
                            Image("phone_icon")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 16, height: 16)
                                .padding()
                        }
                        Text(self.output.usernameValidationMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                        CustomSecureTextField(password: $input.password)
                        Text(self.output.passwordValidationMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                        CustomSecureTextField(placeholder: "CONFIRM_PASSWORD".localizedString, password: $input.repeatedPassword)
                        Text(self.output.repeatedPasswordValidationMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                        
                        Button {
                            self.registerTrigger.send(())
                        } label: {
                            Text("REGISTER".localizedString)
                                .frame(maxWidth: .infinity, maxHeight: 40)
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .disabled(!self.output.isRegisterEnabled)
                                .cornerRadius(12)
                                .padding(.top, 16)
                        }
                        
                        HStack {
                            Spacer()
                            Button("ALREADY_REGISTERED".localizedString) {
                                self.showLoginTrigger.send(Void())
                            }
                            .foregroundColor(Color(hex: "#51526C"))
                            Spacer()
                        }
                        .padding()
                    }
                    .padding(.horizontal, 16)
                    Spacer()
                }
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
