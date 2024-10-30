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
    var addRow: Bool = false
    var didSelectInformation: ((Dealer) -> Void)?
    var addDealerAction: () -> Void
    
    init(width: CGFloat, model: Dealer, didSelectInformation: ((Dealer) -> Void)? = nil) {
        self.width = width
        self.model = model
        self.didSelectInformation = didSelectInformation
        self.addDealerAction = { }
    }
    
    init(addRow: Bool, width: CGFloat, addDealerAction: @escaping () -> Void) {
        self.addRow = addRow
        self.width = width
        self.model = Dealer(dealerId: nil, dealerClientCid: nil, name: nil, clientName: nil, balance: 0, purchaseForMonth: 0, purchaseForYear: 0)
        self.addDealerAction = addDealerAction
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                if addRow {
                    HStack {
                        Spacer()
                        Image(systemName: "plus.app")
                            .resizable()
                            .foregroundStyle(Colors.customRedColor)
                            .frame(width: 24, height: 24)
                        Text("ADD_DEALER".localizedString)
                            .font(.headline)
                            .foregroundStyle(Colors.customRedColor)
                        Spacer()
                    }
                    .frame(height: 80)
                    .onTapGesture {
                        addDealerAction()
                    }
                } else {
                    HStack {
                        VStack {
                            HStack(spacing: 8) {
                                Text("DEALER".localizedString)
                                    .foregroundColor(Colors.secondaryTextColor)
                                    .font(.subheadline)
                                Text(model.name ?? " ")
                                    .foregroundColor(Colors.primaryTextColor)
                                    .font(.headline)
                                Spacer()
                            }
                            HStack(spacing: 8) {
                                Text("BALANCE".localizedString)
                                    .font(.subheadline)
                                    .foregroundColor(Color(hex: "#9DA8C2"))
                                Text(model.balance.convertDecimals() + "SUM_UZS".localizedString)
                                    .font(.headline)
                                    .foregroundColor(model.balance >= 0 ? .green : .red)
                                Spacer()
                            }
                        }
                        .padding()
                        Spacer()
                        VStack {
                            Button {
                                didSelectInformation?(model)
                            } label: {
                                Image("info")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .padding()
                            }
                        }
                    }
                    .frame(height: 80)
                }

            }
            .background(.white)
            .border(Color(hex: "#E2E5ED"), width: 0.5)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.2), radius: 2)
            .frame(height: 80)
            .padding(.horizontal, 20)
//            .padding(.vertical, 20)
            
            
        }
        .frame(width: self.width)
        
    }
}
