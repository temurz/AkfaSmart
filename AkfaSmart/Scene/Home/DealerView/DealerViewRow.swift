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
                    VStack {
                        HStack {
                            Label("DEALER".localizedString, image: "account_circle")
                                .foregroundColor(Color(hex: "#9DA8C2"))
                                .font(.subheadline)
                            Spacer()
                            Text(model.name ?? " ")
                                .foregroundColor(Color(hex: "#51526C"))
                                .font(.headline)
                        }
                        
                        HStack {
                            Label("CLIENT".localizedString, image: "account_circle")
                                .foregroundColor(Color(hex: "#9DA8C2"))
                                .font(.subheadline)
                            Spacer()
                            Text(model.clientName ?? " ")
                                .multilineTextAlignment(.trailing)
                                .lineLimit(2)
                                .foregroundColor(Color(hex: "#51526C"))
                                .font(.headline)
                        }
                        
                        HStack {
                            Label("BALANCE".localizedString, image: "account_balance_wallet")
                                .font(.subheadline)
                                .foregroundColor(Color(hex: "#9DA8C2"))
                            Spacer()
                            if isBalanceVisible {
                                Text(model.balance.convertDecimals() + "SUM_UZS".localizedString)
                                    .font(.headline)
                                    .foregroundColor(model.balance >= 0 ? .green : .red)
                            }else {
                                Text("***" + "SUM_UZS".localizedString)
                                    .font(.headline)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding([.horizontal, .top])
                    Divider()
                }
                .background(Color(hex: "#F6F8FC"))
                
                Text("SUM_OF_BOUGHT_GOODS".localizedString)
                    .font(.headline)
                    .padding(.horizontal)
                HStack {
                    Text("FOR_MONTH".localizedString)
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
                .padding()
                

                HStack {
                    Text("FOR_YEAR".localizedString)
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
                .padding()
                
                Divider()
                
            }
            .background(.white)
            .border(Color(hex: "#E2E5ED"), width: 0.5)
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            
            
        }
        .frame(width: self.width)
        
    }
}
