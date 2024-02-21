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
                    .padding(.bottom)
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Forgot password?")
                            .font(.title)
                            .padding(.horizontal)
                    
                        Text("Enter your phone number in order to reset your password")
                            .foregroundColor(Color(hex: "#51526C"))
                            .font(.system(size: 17))
                            .padding([.bottom,.horizontal])
                        ZStack(alignment: .leading) {
                            NumberPhoneMaskView(number: $input.phoneNumber)
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
                        Text(output.usernameValidationMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                    
                    Spacer()
                    HStack {
                        Button {
                            confirmPhoneNumberTrigger.send(())
                        }label: {
                            Text("Confirm")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                    
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
