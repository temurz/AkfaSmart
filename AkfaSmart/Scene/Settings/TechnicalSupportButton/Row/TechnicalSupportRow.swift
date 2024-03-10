//
//  TechnicalSupportRow.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 10/03/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct Message {
    let isUser: Bool
    let time: String
    let text: String
}

struct MessageViewRow: View {
    var model: Message
    
    var body: some View {
        
        VStack(alignment: model.isUser ? .trailing : .leading) {

            HStack {
                
                if model.isUser {
                    Spacer()
                }
                
                VStack (alignment: model.isUser ? .leading : .trailing) {
                    
                    Text(model.text)
                        .font(.headline)
                        .foregroundStyle(model.isUser ? .white : .black)
                        .padding()
                        .background(model.isUser ? .red : .blue)
                        .cornerRadius(12, corners: model.isUser ?
                                      [.topLeft, .topRight, .bottomLeft] :  [.topRight, .bottomRight , .bottomLeft])
                    
                    Text(model.time)
                        .font(.subheadline)
                        .foregroundStyle(Color(hex: "#AEACBC"))
                    
                }
                
                
                if !model.isUser {
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(model.isUser ? .leading : .trailing)
    }
}

#Preview {
    MessageViewRow(model: Message(isUser: true, time: "11.03.2024", text: "Hiadadaddakdkdakadkdakdakadkdpkadapdakpdkakdapkdapkdakppdak"))
}
