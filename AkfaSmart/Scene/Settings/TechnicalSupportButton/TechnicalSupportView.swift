//
//  TechnicalSupportView.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 10/03/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct TechnicalSupportView: View {
    @State private var messageText = ""

    var body: some View {
        
        VStack {
            List {
                MessageViewRow(model: Message(isUser: true, time: "20.10.2019", text: "jdifgjidfjgdjfgijdfijgidfjgijdfigjdfi"))
                MessageViewRow(model: Message(isUser: false, time: "20.10.2019", text: "jdifgjidfjgdjfgijdfijgidfjgijdfigjdfi"))
                    .listRowSeparator(.hidden)
            }.listStyle(.plain)

            HStack {
                TextField("Написать", text: $messageText)
                    .padding(.leading, 8)
                    .frame(height: 40)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                Button(action: {
                    
                    print("Sending message: \(messageText)")
                    self.messageText = ""
                    
                }) {
                    
                    Image(systemName: "paperplane")
                        .foregroundColor(.blue)
                        .padding(.trailing, 8)
                    
                }
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(10)
        }
        .navigationTitle("Chat")
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        TechnicalSupportView()
    }
}
