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
    private let popViewControllerTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: .constant(false), text: .constant("")) {
            VStack(alignment: .leading) {
                CustomNavigationBar(title: "PRODUCT_GRAPHICS_TITLE".localizedString) {
                    popViewControllerTrigger.send(())
                }
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
                            ProductGraphicsDetailRow(
                                model: ProductGraphicsDetailModel(
                                    title: "ANNUAL_BUY_WEIGHT".localizedString,
                                    detailArray: graphics.annualBuyWeightDetail)
                            )
                        }
                    }
                    .padding()
                }
            }
        }
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
        return amount.convertDecimals()
    }
    
    init(viewModel: ProductGraphicsViewModel) {
        let input = ProductGraphicsViewModel.Input(
            requestProductGraphicsTrigger: requestProductGraphicsTrigger.asDriver(),
            popViewControllerTrigger: popViewControllerTrigger.asDriver())
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

struct ProductGraphicsDetailModel {
    let title: String
    let detailArray: [BuyWeightDetail]
}

struct ProductGraphicsDetailRow: View {
    let model: ProductGraphicsDetailModel
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(model.title)
                .foregroundColor(Color(hex: "#9DA8C2"))
            ForEach(model.detailArray, id: \.id) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    Text(item.weight.convertDecimals())
                }
            }
        }
        
    }
}
