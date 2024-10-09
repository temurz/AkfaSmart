//
//  CustomSecureTextField.swift
//  AkfaSmart
//
//  Created by Temur on 09/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
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
            .frame(height: 50)
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
                .background(Color(hex: "#FDFDFF"))
            
            
            
            HStack(alignment: .center) {
                Image("key")
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 18, height: 18)
                    .padding()
                Spacer()
                
                Image(systemName: eyeImage)
                    .resizable()
                    .foregroundStyle(Colors.iconGrayColor)
                    .frame(width: 24, height: 16)
                    .padding()
                    .onTapGesture {
                        isShowingPassword.toggle()
                        eyeImage = isShowingPassword ? "eye.slash" : "eye"
                    }
                
            }
        }
        .frame(height: 50)
    }
    
    init(placeholder: String = "PASSWORD".localizedString, password: Binding<String>) {
        self.placeholder = placeholder
        self._password = password
    }
}
