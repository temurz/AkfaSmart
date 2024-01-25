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

    private let cancelBag = CancelBag()
    private let loginTrigger = PassthroughSubject<Void, Never>()
    
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
                        Text("Login")
                            .font(.title)
                            .padding(.top, 16)
                        TextField("", text: self.$input.username)
                            .frame(height: 50)
                            .background(Color(hex: "#F5F7FA"))
                            .cornerRadius(12)
                        Text(self.output.usernameValidationMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                        SecureField("", text: self.$input.password)
                            .frame(height: 50)
                            .background(Color(hex: "#F5F7FA"))
                            .cornerRadius(12)
                            .padding(.top)
                        Text(self.output.passwordValidationMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                        HStack {
                            Spacer()
                            Button("Forgot password?") {
                                
                            }
                            .foregroundColor(.black)
                            Spacer()
                        }
                        Button("Login") {
                            self.loginTrigger.send(())
                        }
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .disabled(!self.output.isLoginEnabled)
                        .cornerRadius(12)
                        .padding(.top, 16)
                        
                        HStack {
                            Spacer()
                            Button("Registration") {
                                
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
        let input = LoginViewModel.Input(loginTrigger: loginTrigger.asDriver())
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
