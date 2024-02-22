//
//  DealerViewRow.swift
//  AkfaSmart
//
//  Created by Temur on 21/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct DealerViewRow: View {
    var width: CGFloat
    var model: Dealer
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Label("Dealer's name", image: "account_circle")
                                .foregroundColor(Color(hex: "#9DA8C2"))
                                .font(.subheadline)
                            Text(model.name ?? " ")
                                .foregroundColor(Color(hex: "#51526C"))
                                .font(.headline)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Label("Balance", image: "account_balance_wallet")
                                .font(.subheadline)
                                .foregroundColor(Color(hex: "#9DA8C2"))
                            Text("\(model.balance) sum")
                                .font(.headline)
                                .foregroundColor(.red)
                        }
                    }
                    .padding([.horizontal, .top])
                    Divider()
                }
                .background(Color(hex: "#F6F8FC"))
                
                Text("Sum of bought goods:")
                    .font(.headline)
                    .padding(.horizontal)
                HStack {
                    Text("For month")
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#9DA8C2"))
                    Spacer()
                    Text("\(model.purchaseForMonth)")
                }
                .padding()
                HStack {
                    Text("For year")
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#9DA8C2"))
                    Spacer()
                    Text("\(model.purchaseForYear)")
                }
                .padding()
                Divider()
                
                HStack {
                    Button {
                        
                    } label: {
                        Text("History of purchases")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "#51526C"))
                            .lineLimit(1)
                            .padding()
                            .background(Color(hex: "#DFE3EB"))
                            .cornerRadius(12)
                            .frame(height: 50)
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("History of payments")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "#51526C"))
                            .lineLimit(1)
                            .padding()
                            .background(Color(hex: "#DFE3EB"))
                            .cornerRadius(12)
                            .frame(height: 50)
                    }
                }
                .padding()
            }
            .background(.white)
            .border(Color(hex: "#E2E5ED"), width: 0.5)
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding(.horizontal, 20)
            .padding(.vertical, 25)
            
            
        }
        .frame(width: self.width)
        
    }
}
