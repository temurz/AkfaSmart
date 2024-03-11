//
//  MarketinggraphicsView.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct MarketingItemViewModel {
    let title: String
    let value: String
}

struct MarketingGraphicsView: View {
    @ObservedObject var output: MarketingGraphicsViewModel.Output
    
    private let requestMarketingGraphicsTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: .constant(false), text: .constant("")) {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    if output.graphics != nil, let graphics = output.graphics {
                        MarketingViewRow(
                            viewModel: MarketingItemViewModel(
                                title: "IS_OFFICE_OR_SHOWROOM".localizedString,
                                value: "OFFICE".localizedString + ConverterToString.getYesOrNoString(graphics.hasOffice) + "OR_SHOWROOM".localizedString + ConverterToString.getYesOrNoString(graphics.hasShowroom))
                        )
                        MarketingViewRow(
                            viewModel: MarketingItemViewModel(
                                title: "ANNUAL_BUSINESS_GROWTH".localizedString,
                                value: "\(getAmount(graphics.annualBusinessGrowth))")
                        )
                        MarketingViewRow(
                            viewModel: MarketingItemViewModel(
                                title: "ANNUAL_SALES_TURNOVER".localizedString,
                                value: "\(getAmount(graphics.annualSalesTurnover))")
                        )
                        MarketingViewRow(
                            viewModel: MarketingItemViewModel(
                                title: "USES_ADVERTISING".localizedString,
                                value: "\(graphics.useAdvertising ?? "NO_INFORMATION".localizedString)")
                        )
                        MarketingViewRow(
                            viewModel: MarketingItemViewModel(
                                title: "USES_OUTDOOR_ADVERTISING".localizedString,
                                value: "\(graphics.numberOfOutdoorAdvertising)")
                        )
                    }
                }
                .padding()
            }
            
        }
        .navigationTitle("MARKETING_GRAPHICS".localizedString)
        .alert(isPresented: $output.alert.isShowing) {
            Alert(title: Text(output.alert.title),
                  message: Text(output.alert.message),
                  dismissButton: .default(Text("OK")))
        }
        .onAppear {
            requestMarketingGraphicsTrigger.send(())
        }
        
    }
    
    private func getAmount(_ amount: Double?) -> String {
        guard let amount else { return "NO_INFORMATION".localizedString}
        return String(format: "%.2f", amount)
    }
    
    init(viewModel: MarketingGraphicsViewModel) {
        let input = MarketingGraphicsViewModel.Input(requestMarketingGraphicsTrigger: requestMarketingGraphicsTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
