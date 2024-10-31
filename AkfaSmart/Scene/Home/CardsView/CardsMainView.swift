//
//  CardsMainView.swift
//  AkfaSmart
//
//  Created by Temur on 28/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct CardsMainView: View {
    @ObservedObject var output: CardsMainViewModel.Output
    private let getCardsTrigger = PassthroughSubject<Void,Never>()
    private let showAddCardViewTrigger = PassthroughSubject<Void,Never>()
    private let selectCardTrigger = PassthroughSubject<Card,Never>()
    private let popViewControllerTrigger = PassthroughSubject<Void,Never>()
    private let deleteCardTrigger = PassthroughSubject<Int,Never>()
    private let cancelBag = CancelBag()
    @State var isLoading = false
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "MY_CARDS".localizedString, rightBarImage: "add") {
                    popViewControllerTrigger.send(())
                } onRightBarButtonTapAction: {
                    showAddCardViewTrigger.send(())
                }
                List(output.cards, id: \.id) { card in
                    CardRowView(model: card)
                        .listRowSeparator(.hidden)
                        .swipeActions {
                            Button {
                                deleteCardTrigger.send(card.id)
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.white)
                            }
                            .tint(Colors.customRedColor)
                        }
                        .onTapGesture {
                            selectCardTrigger.send(card)
                        }
                }
                .listStyle(.plain)
                
            }
            .background(Color.clear)
        }
        .onAppear {
            getCardsTrigger.send(())
        }
        
    }
    
    init(viewModel: CardsMainViewModel) {
        let input = CardsMainViewModel.Input(
            getCardsTrigger: getCardsTrigger.asDriver(),
            showAddCardViewTrigger: showAddCardViewTrigger.asDriver(),
            selectCardTrigger: selectCardTrigger.asDriver(),
            popViewControllerTrigger: popViewControllerTrigger.asDriver(),
            deleteCardTrigger: deleteCardTrigger.asDriver()
        )
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
