//
//  ForgotPasswordView.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var phoneNumber = ""
    @State var statusBarHeight: CGFloat = 0
    @State var isLoading = false
    var body: some View {
        LoadingView(isShowing: $isLoading, text: .constant("")) {
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
                        TextField("Phone number", text: $phoneNumber)
                            .multilineTextAlignment(.center)
                            .frame(height: 48)
                            .background(Color(hex: "#F5F7FA"))
                            .cornerRadius(12)
                            .padding([.top, .horizontal])
                    }
                    
                    Spacer()
                    HStack {
                        Button("Reset password") {
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(12)
                    }
                    .padding()
                    
                }
                .padding()
            }
        }
    }
}

#Preview {
    ForgotPasswordView()
}
