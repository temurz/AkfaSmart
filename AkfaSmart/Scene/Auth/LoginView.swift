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
    @State private var eyeImage = "eye"
    @State private var isShowingPassword = false

    private let cancelBag = CancelBag()
    private let loginTrigger = PassthroughSubject<Void, Never>()
    private let showRegisterTrigger = PassthroughSubject<Void, Never>()
    private let showForgotPasswordTrigger = PassthroughSubject<Void,Never>()
    
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
                        Text("LOGIN".localizedString)
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
                            .frame(width: 18, height: 18)
                            .padding()
                    }
                    Text(self.output.usernameValidationMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                    CustomSecureTextField(password: $input.password)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(self.output.passwordValidationMessage.isEmpty ? Colors.borderGrayColor : .red, lineWidth: self.output.passwordValidationMessage.isEmpty ? 1 : 2)
                        }
                        .padding(.top)
                    Text(self.output.passwordValidationMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                    HStack {
                        Spacer()
                        Button{
                            showForgotPasswordTrigger.send(())
                        } label: {
                            Text("FORGOT_PASSWORD_QUESTION".localizedString)
                                .font(.subheadline)
                        }
                        .foregroundColor(.black)
                    }
                    Button() {
                        self.loginTrigger.send(())
                    } label: {
                        Text("LOGIN".localizedString)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(Color.white)
                            .background(Colors.customRedColor)
                            .disabled(!self.output.isLoginEnabled)
                            .cornerRadius(8)
                    }
                    .padding(.top, 24)
                    Button {
                        self.showRegisterTrigger.send(())
                    } label: {
                        Text("REGISTRATION".localizedString)
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
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Button("O'zbekcha") {
                            AuthApp.shared.language = "uz"
                            input.reload = true
                        }
                        .foregroundStyle(.black)
                        Button("Русский") {
                            AuthApp.shared.language = "ru"
                            input.reload = true
                        }
                        .foregroundStyle(.black)
                    }
                    Spacer()
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


