//
//  MyDealersView.swift
//  AkfaSmart
//
//  Created by Temur on 01/12/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct MyDealersView: View {
    @ObservedObject var output: MyDealersViewModel.Output
    
    private let getDealersTrigger = PassthroughSubject<Void,Never>()
    private let showDealerDetails = PassthroughSubject<Dealer,Never>()
    private let backTrigger = PassthroughSubject<Void, Never>()
    private let addDealerTrigger = PassthroughSubject<Void, Never>()
    private let cancelBag = CancelBag()
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "MY_DEALERS".localizedString, rightBarImage: "add") {
                    backTrigger.send(())
                } onRightBarButtonTapAction: {
                    addDealerTrigger.send(())
                }
                ForEach(output.dealers, id: \.dealerClientCid) { model in
                    MyDealerRow(model: model)
                        .onTapGesture {
                            showDealerDetails.send(model)
                        }
                }
            }
            .onAppear {
                getDealersTrigger.send(())
            }
        }
    }
    
    init(viewModel: MyDealersViewModel) {
        let input = MyDealersViewModel.Input(
            getDealersTrigger: getDealersTrigger.asDriver(), 
            showDealerDetailTrigger: showDealerDetails.asDriver(),
            addDealerTrigger: addDealerTrigger.asDriver(),
            backTrigger: backTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
