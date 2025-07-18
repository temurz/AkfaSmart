//
//  PromotionDetailView.swift
//  AkfaSmart
//
//  Created by Temur on 14/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct PromotionDetailView: View {
    private let popViewTrigger = PassthroughSubject<Void,Never>()
    private let myCouponsTrigger = PassthroughSubject<Void,Never>()
    
    @ObservedObject var output: PromotionDetailViewModel.Output
    private let cancelBag = CancelBag()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                WebView(html: output.promotion.htmlContent ?? "")
                    .background(Color(hex: output.promotion.backgroundColor ?? "#86B1E0"))
            }
            VStack(alignment: .leading) {
                Button {
                    popViewTrigger.send(())
                } label: {
                    Image(.arrowBack)
                        .renderingMode(.template)
                        .foregroundStyle(.white)
                        .padding(4)
                        .overlay {
                            Circle()
                                .fill(.gray.opacity(0.2))
                        }
                        .padding()
                }
                Spacer()
                ScrollView(.horizontal) {
                    HStack {
                        Spacer()
                            .frame(width: 16)
                        if let items = output.promotion.couponInfo?.crmCouponContent {
                            ForEach(items, id: \.loyaltyCardId) { item in
                                CouponRuleCellView(model: item)
                                    .frame(width: Constants.screenWidth - 32)
                                    .background(.clear)
                            }
                            
                        }
                        Spacer()
                            .frame(width: 16)
                    }
                    .background(.clear)
                    
                }
                .scrollIndicators(.hidden)
                .fixedSize(horizontal: false, vertical: true)
                Button {
                    myCouponsTrigger.send(())
                } label: {
                    Text("MY_COUPONS".localizedString)
                        .foregroundStyle(.white)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Colors.customRedColor)
                .cornerRadius(8, corners: .allCorners)
                .padding()
                
            }
            
        }
    }
    
    init(viewModel: PromotionDetailViewModel) {
        let input = PromotionDetailViewModel.Input(
            popViewTrigger: popViewTrigger.asDriver(),
            myCouponsTrigger: myCouponsTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
