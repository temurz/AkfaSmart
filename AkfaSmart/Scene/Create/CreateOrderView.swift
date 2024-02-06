//
//  CreateOrderView.swift
//  AkfaSmart
//
//  Created by Temur on 06/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct CreateOrderView: View {
    @State private var selection = 0
    @State var creationType: String = "Create buying"
    var body: some View {
        VStack {
            Picker("", selection: $selection) {
                Text("Create buying").tag(0)
                Text("Create return").tag(1)
            }
            .pickerStyle(.segmented)
            .frame(height: 32)
            .padding()
            
            VStack() {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Image("add-square")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 52, height: 52)
                    .background(Color.red)
                    .cornerRadius(14)
                    .padding(24)
                    .shadow(radius: 4, y: 4)
                }
            }
        }
        .navigationTitle("Create order")
        .navigationBarHidden(false)
        .navigationBarItems(trailing:
            Button(action: {
            
            }, label: {
            Text("Save")
                .font(.headline)
                .foregroundColor(.red)
            })
        )
    }
    
    init(viewModel: CreateOrderViewModel) {
        
    }
}
