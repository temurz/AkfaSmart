//
//  AddCardView.swift
//  AkfaSmart
//
//  Created by Temur on 28/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct AddCardView: View {
    @ObservedObject var output: AddCardViewModel.Output
    private let popViewControllerTrigger = PassthroughSubject<Void,Never>()
    let cancelBag = CancelBag()
    
    var body: some View {
        VStack {
            CustomNavigationBar(title: "ADD_CARD".localizedString) {
                popViewControllerTrigger.send(())
            }
            CardsCarousel(data: $output.coloredCards)
        }
    }
    
    init(viewModel: AddCardViewModel) {
        let input = AddCardViewModel.Input(
            popViewControllerTrigger: popViewControllerTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
