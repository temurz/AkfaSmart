//
//  AddCardViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 28/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct AddCardViewModel {
    let addCardUseCase: AddCardViewUseCaseType
    let navigator: AddCardViewNavigatorType
}

extension AddCardViewModel: ViewModel {
    struct Input {
        let popViewControllerTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var coloredCards = [
            Card(id: 0, balance: 0.0, cardNumber: "000000000000", displayName: "CARD_NAME".localizedString, cardBackground: Colors.secondCardGradientHexString, cardHolderPhone: nil, isMain: false, isBlocked: false, status: nil),
            Card(id: 1, balance: 0.0, cardNumber: "000000000000", displayName: "CARD_NAME".localizedString, cardBackground: Colors.redCardGradientHexString, cardHolderPhone: nil, isMain: false, isBlocked: false, status: nil),
            Card(id: 2, balance: 0.0, cardNumber: "000000000000", displayName: "CARD_NAME".localizedString, cardBackground: Colors.thirdCardGradientHexString, cardHolderPhone: nil, isMain: false, isBlocked: false, status: nil),
            Card(id: 3, balance: 0.0, cardNumber: "000000000000", displayName: "CARD_NAME".localizedString, cardBackground: Colors.fourthCardGradientHexString, cardHolderPhone: nil, isMain: false, isBlocked: false, status: nil),
        ]
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        
        input.popViewControllerTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)
        
        return output
    }
}
