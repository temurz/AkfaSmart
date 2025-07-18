//
//  PromotionsListView.swift
//  AkfaSmart
//
//  Created by Temur on 18/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct PromotionsListView: View {
    @ObservedObject var output: PromotionsListViewModel.Output
    private let cancelBag = CancelBag()
    
    private let popViewTrigger = PassthroughSubject<Void, Never>()
    private let selectPromotionTrigger = PassthroughSubject<Promotion, Never>()
    
    var body: some View {
        VStack {
            CustomNavigationBar(title: "PROMOTIONS".localizedString) {
                popViewTrigger.send(())
            }
            ScrollView {
                VStack {
                    ForEach(output.promotions, id: \.id) { promotion in
                        PromotionViewCell(model: promotion)
                            .onTapGesture {
                                selectPromotionTrigger.send(promotion)
                            }
                    }
                }
                .padding()
            }
        }
    }
    
    init(viewModel: PromotionsListViewModel) {
        let input = PromotionsListViewModel.Input(
            popViewTrigger: popViewTrigger.asDriver(),
            selectPromotionTrigger: selectPromotionTrigger.asDriver())
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
