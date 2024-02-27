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
                                title: "Is there an office or showroom",
                                value: "Office \(ConverterToString.getYesOrNoString(graphics.hasOffice)) / showroom \(ConverterToString.getYesOrNoString(graphics.hasShowroom))")
                        )
                        MarketingViewRow(
                            viewModel: MarketingItemViewModel(
                                title: "Annual business growth",
                                value: "\(getAmount(graphics.annualBusinessGrowth))")
                        )
                        MarketingViewRow(
                            viewModel: MarketingItemViewModel(
                                title: "Annual sales turnover",
                                value: "\(getAmount(graphics.annualSalesTurnover))")
                        )
                        MarketingViewRow(
                            viewModel: MarketingItemViewModel(
                                title: "Uses advertising",
                                value: "\(graphics.useAdvertising ?? "No information")")
                        )
                        MarketingViewRow(
                            viewModel: MarketingItemViewModel(
                                title: "Uses outdoor advertising",
                                value: "\(graphics.numberOfOutdoorAdvertising)")
                        )
                    }
                }
                .padding()
            }
            
        }
        .navigationTitle("Marketing graphics")
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
        guard let amount else { return "No Information"}
        return String(format: "%.2f", amount)
    }
    
    init(viewModel: MarketingGraphicsViewModel) {
        let input = MarketingGraphicsViewModel.Input(requestMarketingGraphicsTrigger: requestMarketingGraphicsTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
