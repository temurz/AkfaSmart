//
//  DealerDetailModalView.swift
//  AkfaSmart
//
//  Created by Temur on 27/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct DealerDetailModalView: View {
    let model: Dealer
    @ObservedObject var output: DealerDetailsViewModel.Output
    private let dismissTrigger = PassthroughSubject<Void,Never>()
    private let openPurchasesTrigger = PassthroughSubject<Void,Never>()
    private let openPaymentsTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    
    var body: some View {
        VStack {
            Button {
                dismissTrigger.send(())
            } label: {
                Color.black.opacity(0.1)
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Color.clear
                        .frame(width: 24, height: 24)
                    Spacer()
                    Text("DEALER_TITLE".localizedString)
                    Spacer()
                    Button {
                        dismissTrigger.send(())
                    } label: {
                        Image("cancel")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                HorizontalSeparatorLine()
                Text("INFORMATION".localizedString)
                    .font(.headline)
                    .bold()
                HStack {
                    Text("DEALER".localizedString)
                        .foregroundStyle(Colors.secondaryTextColor)
                        .font(.callout)
                    Text(model.name ?? " ")
                        .foregroundStyle(Colors.primaryTextColor)
                        .font(.body)
                    Spacer()
                }
                HStack {
                    Text("BALANCE".localizedString)
                        .foregroundStyle(Colors.secondaryTextColor)
                        .font(.callout)
                    Text(model.balance.convertDecimals() + "SUM_UZS".localizedString)
                        .foregroundStyle(Colors.customRedColor)
                        .font(.body)
                    Spacer()
                }
                HStack {
                    Text("CLIENT".localizedString)
                        .foregroundStyle(Colors.secondaryTextColor)
                        .font(.callout)
                    Text(model.clientName ?? " ")
                        .foregroundStyle(Colors.primaryTextColor)
                        .font(.body)
                    Spacer()
                }
                Text("EXPENSES".localizedString)
                    .font(.headline)
                    .bold()
                HStack {
                    Text("FOR_MONTH".localizedString + ":")
                        .foregroundStyle(Colors.secondaryTextColor)
                        .font(.callout)
                    Text(model.purchaseForMonth.convertDecimals() + "SUM_UZS".localizedString)
                        .foregroundStyle(Colors.customRedColor)
                        .font(.body)
                    Spacer()
                }
                HStack {
                    Text("FOR_YEAR".localizedString + ":")
                        .foregroundStyle(Colors.secondaryTextColor)
                        .font(.callout)
                    Text(model.purchaseForYear.convertDecimals() + "SUM_UZS".localizedString)
                        .foregroundStyle(Colors.customRedColor)
                        .font(.body)
                    Spacer()
                }
                HorizontalSeparatorLine()
                HStack {
                    Button {
                        dismissTrigger.send(())
                        openPurchasesTrigger.send(())
                    } label: {
                        Text("HISTORY_OF_PURCHASES".localizedString)
                            .font(.system(size: 15))
                            .foregroundColor(Color(hex: "#51526C"))
                            .lineLimit(1)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            .background(Color(hex: "#DFE3EB"))
                            .cornerRadius(12)
                    }
                    Button {
                        dismissTrigger.send(())
                        openPaymentsTrigger.send(())
                    } label: {
                        Text("HISTORY_OF_PAYMENTS".localizedString)
                            .font(.system(size: 15))
                            .foregroundColor(Color(hex: "#51526C"))
                            .lineLimit(1)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            .background(Color(hex: "#DFE3EB"))
                            .cornerRadius(12)
                    }
                }
                .padding(.bottom)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea(.all)
        .background(Color.clear)
    }
    
    init(model: Dealer, viewModel: DealerDetailsViewModel) {
        self.model = model
        let input = DealerDetailsViewModel.Input(dismissTrigger: dismissTrigger.asDriver(), openPurchasesTrigger: openPurchasesTrigger.asDriver(), openPaymentsTrigger: openPaymentsTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
