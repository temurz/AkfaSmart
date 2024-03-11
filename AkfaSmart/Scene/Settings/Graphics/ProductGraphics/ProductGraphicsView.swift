//
//  SecretgraphicsView.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct ProductGraphicsView: View {
    @ObservedObject var output: ProductGraphicsViewModel.Output
    
    private let requestProductGraphicsTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: .constant(false), text: .constant("")) {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    if output.graphics != nil, let graphics = output.graphics {
                        MarketingViewRow(
                            viewModel: MarketingItemViewModel(
                                title: "ANNUAL_BUY_AMOUNT".localizedString,
                                value: getAmount(graphics.annualBuyAmount))
                        )
                        MarketingViewRow(
                            viewModel: MarketingItemViewModel(
                                title: "ANNUAL_BUY_WEIGHT".localizedString,
                                value: getAmount(graphics.annualBuyWeight))
                        )
                        MarketingViewRow(
                            viewModel: MarketingItemViewModel(
                                title: "DEALER_NAMES".localizedString,
                                value: graphics.dealerNames)
                        )
                        MarketingViewRow(
                            viewModel: MarketingItemViewModel(
                                title: "ANNUAL_BUY_WEIGHT".localizedString,
                                value: getBuyWeightDetail(details: graphics.annualBuyWeightDetail))
                        )
                    }
                    
                }
                .padding()
            }
        }
        .navigationTitle("PRODUCT_GRAPHICS_TITLE".localizedString)
        .alert(isPresented: $output.alert.isShowing) {
            Alert(title: Text(output.alert.title),
                  message: Text(output.alert.message),
                  dismissButton: .default(Text("OK")))
        }
        .onAppear {
            requestProductGraphicsTrigger.send(())
        }
        
    }
    
    private func getAmount(_ amount: Double?) -> String {
        guard let amount else { return "NO_INFORMATION".localizedString}
        return String(format: "%.2f", amount)
    }
    
    private func getBuyWeightDetail(details: [BuyWeightDetail]) -> String {
        let namesAndWeights = details.map { ($0.name, $0.weight) }
        var text = ""
        namesAndWeights.forEach { name, weight in
            text += name
            text += " "
            text += "\(weight)"
            text += "\r\n"
        }
        return text
    }
    
    init(viewModel: ProductGraphicsViewModel) {
        let input = ProductGraphicsViewModel.Input(requestProductGraphicsTrigger: requestProductGraphicsTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
