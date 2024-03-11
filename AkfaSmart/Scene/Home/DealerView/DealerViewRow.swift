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
                            Label("DEALERS_NAME".localizedString, image: "account_circle")
                                .foregroundColor(Color(hex: "#9DA8C2"))
                                .font(.subheadline)
                            Text(model.name ?? " ")
                                .foregroundColor(Color(hex: "#51526C"))
                                .font(.headline)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Label("BALANCE".localizedString, image: "account_balance_wallet")
                                .font(.subheadline)
                                .foregroundColor(Color(hex: "#9DA8C2"))
                            if isBalanceVisible {
                                Text(model.balance.convertDecimals() + "SUM_UZS".localizedString)
                                    .font(.headline)
                                    .foregroundColor(.red)
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
                .padding(.horizontal)
                

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
                .padding(.horizontal)
                
                Divider()
                
                HStack {
                    Button {
                        openPurchases(model.dealerId ?? 0)
                    } label: {
                        Text("HISTORY_OF_PURCHASES".localizedString)
                            .font(.system(size: 12))
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
                        Text("HISTORY_OF_PAYMENTS".localizedString)
                            .font(.system(size: 12))
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
