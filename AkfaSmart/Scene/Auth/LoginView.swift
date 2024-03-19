//
//  LoginView.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/29/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct LoginView: View {
    @ObservedObject var input: LoginViewModel.Input
    @ObservedObject var output: LoginViewModel.Output
    @State private var statusBarHeight: CGFloat = 0
    @State private var eyeImage = "eye"
    @State private var isShowingPassword = false

    private let cancelBag = CancelBag()
    private let loginTrigger = PassthroughSubject<Void, Never>()
    private let showRegisterTrigger = PassthroughSubject<Void, Never>()
    private let showForgotPasswordTrigger = PassthroughSubject<Void,Never>()
    
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
                        Text("LOGIN".localizedString)
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
                        .padding(.top)
                        
                        Text(self.output.passwordValidationMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                        HStack {
                            Spacer()
                            Button("FORGOT_PASSWORD_QUESTION".localizedString) {
                                showForgotPasswordTrigger.send(())
                            }
                            .foregroundColor(.black)
                            Spacer()
                        }
                        Button() {
                            self.loginTrigger.send(())
                        } label: {
                            Text("LOGIN".localizedString)
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .disabled(!self.output.isLoginEnabled)
                                .cornerRadius(12)
                                .padding(.top, 16)
                        }
                        
                        
                        HStack {
                            Spacer()
                            Button("REGISTRATION".localizedString) {
                                self.showRegisterTrigger.send(())
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
    
    init(viewModel: LoginViewModel) {
        let input = LoginViewModel.Input(loginTrigger: loginTrigger.asDriver(), showRegisterTrigger: showRegisterTrigger.asDriver(),
            showForgotPasswordTrigger: showForgotPasswordTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: LoginViewModel = PreviewAssembler().resolve(navigationController: UINavigationController())
        return LoginView(viewModel: viewModel)
    }
}

public extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

public struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CustomPhoneNumberTextField: View {
    @Binding var text: String
    var body: some View {
        TextField("", text: $text)
    }
}

struct CustomSecureTextField: View {
    @State private var isShowingPassword: Bool = false
    @State private var eyeImage: String = "eye"
    
    let placeholder: String
    @Binding var password: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Group {
                if isShowingPassword {
                    TextField(placeholder, text: $password)
                        .padding(.horizontal)
                }else {
                    SecureField(placeholder, text: $password)
                        .padding(.horizontal)
                }
            }
            .frame(height: 48)
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
                .background(Color(hex: "#F5F7FA"))
                .cornerRadius(12)
            
            
            
            HStack(alignment: .center) {
                Image("key_square")
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 18, height: 18)
                    .padding()
                Spacer()
                
                Image(systemName: eyeImage)
                    .resizable()
                    .tint(.gray)
                    .frame(width: 20, height: 16)
                    .padding()
                    .onTapGesture {
                        isShowingPassword.toggle()
                        eyeImage = isShowingPassword ? "eye.slash" : "eye"
                    }
                
            }
        }
        .frame(height: 48)
    }
    
    init(placeholder: String = "PASSWORD".localizedString, password: Binding<String>) {
        self.placeholder = placeholder
        self._password = password
    }
}
