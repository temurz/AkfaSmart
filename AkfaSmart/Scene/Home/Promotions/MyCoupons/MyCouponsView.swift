//
//  MyCouponsView.swift
//  AkfaSmart
//
//  Created by Temur on 18/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct MyCouponsView: View {
    private let popViewTrigger = PassthroughSubject<Void,Never>()
    private let onAppearTrigger = PassthroughSubject<Void,Never>()
    
    @ObservedObject var output: MyCouponsViewModel.Output
    private let cancelBag = CancelBag()
    
    var body: some View {
        VStack {
            CustomNavigationBar(title: "MY_COUPONS".localizedString) {
                popViewTrigger.send(())
            }
            if output.items.isEmpty {
                VStack {
                    Spacer()
                    Text("NO_COUPON".localizedString)
                        .font(.title3)
                        .foregroundStyle(Colors.textSteelColor)
                        .bold()
                        .lineLimit(nil)
                    Spacer()
                }
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(output.items) { item in
                            CouponItemCellView(model: item)
                        }
                    }
                    .padding()
                }
            }
            
        }
        .onAppear {
            onAppearTrigger.send(())
        }
    }
    
    init(viewModel: MyCouponsViewModel) {
        let input = MyCouponsViewModel.Input(
            popViewTrigger: popViewTrigger.asDriver(),
            onAppearTrigger: onAppearTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
