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
    var isBalanceVisible: Bool
    @Binding var totalOfMonth: Double
    @Binding var totalOfYear: Double
    var openPurchases: ((Int) -> ())
    var openPayments: ((Int) -> ())
    
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
                            if isBalanceVisible {
                                Text(model.balance.convertDecimals() + " sum")
                                    .font(.headline)
                                    .foregroundColor(.red)
                            }else {
                                Text("*** sum")
                                    .font(.headline)
                                    .foregroundColor(.red)
                            }
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
                    if isBalanceVisible {
                        Text(model.purchaseForMonth.convertDecimals())
                    }else {
                        Text("***")
                    }
                }
                .padding(.horizontal)
                
                ZStack {
                    Color.gray
                        .cornerRadius(2)
                        .frame(height: 4)
                    if totalOfMonth != 0 {
                        HStack {
                            GeometryReader { g in
                                Color.red
                                    .cornerRadius(2)
                                    .frame(width: CGFloat(
                                        (model.purchaseForMonth / totalOfMonth) * g.size.width))
                                    .frame(height: 4)
                                    
                            }
                            Spacer()
                        }
                        
                    }
                }
                .frame(height: 4)
                .padding(.horizontal)
                

                HStack {
                    Text("For year")
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#9DA8C2"))
                    Spacer()
                    if isBalanceVisible {
                        Text(model.purchaseForYear.convertDecimals())
                    }else {
                        Text("***")
                    }
                }
                .padding(.horizontal)
                
                ZStack {
                    Color.gray
                        .cornerRadius(2)
                        .frame(height: 4)
                    if totalOfYear != 0 {
                        HStack {
                            GeometryReader { g in
                                Color.red
                                    .cornerRadius(2)
                                    .frame(width: CGFloat(
                                        (model.purchaseForYear / totalOfYear) * g.size.width))
                                    .frame(height: 4)
                                    
                            }
                            Spacer()
                        }
                        
                    }
                }
                .frame(height: 4)
                .padding(.horizontal)
                
                Divider()
                
                HStack {
                    Button {
                        openPurchases(model.dealerId ?? 0)
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
                        openPayments(model.dealerId ?? 0)
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
                .padding(16)
            }
            .background(.white)
            .border(Color(hex: "#E2E5ED"), width: 0.5)
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            
            
        }
        .frame(width: self.width)
        
    }
}
