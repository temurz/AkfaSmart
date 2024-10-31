//
//  AddCardViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 28/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import Combine
struct AddCardViewModel {
    let addCardUseCase: AddCardViewUseCaseType
    let navigator: AddCardViewNavigatorType
}

extension AddCardViewModel: ViewModel {
    struct Input {
        let popViewControllerTrigger: Driver<Void>
        let addCardTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var phoneNumber = "998"
        @Published var phoneNumberValidationMessage = ""
        @Published var cardNumber = ""
        @Published var cardNumberValidationMessage = ""
        @Published var cardName = ""
        @Published var cardNameValidationMessage = ""
        @Published var isMain = false
        @Published var cardIndex = 0
        @Published var targetIndex: Int? = nil
        @Published var isAddingEnabled = false
        @Published var alert = AlertMessage()
        @Published var isLoading = false
        
        @Published var coloredCards = [
            Card(id: 0, cardNumber: nil, displayName: "CARD_NAME".localizedString, cardBackground: Colors.mustardCardGradientHexString, isMain: false),
            Card(id: 1, cardNumber: nil, displayName: "CARD_NAME".localizedString, cardBackground: Colors.redCardGradientHexString, isMain: false),
            Card(id: 2, cardNumber: nil, displayName: "CARD_NAME".localizedString, cardBackground: Colors.blueCardGradientHexString, isMain: false),
            Card(id: 3, cardNumber: nil,  displayName: "CARD_NAME".localizedString, cardBackground: Colors.purpleCardGradientHexString,  isMain: false)
        ]
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        
        let phoneNumberValidation = Publishers
            .CombineLatest(output.$phoneNumber, input.addCardTrigger)
            .map { $0.0 }
            .map(LoginDto.validateUserName(_:))
            .map { $0.message }
        
        phoneNumberValidation
            .asDriver()
            .map { $0 }
            .assign(to: \.phoneNumberValidationMessage, on: output)
            .store(in: cancelBag)
        
        let cardNumberValidation = Publishers
            .CombineLatest(output.$cardNumber, input.addCardTrigger)
            .map { $0.0 }
            .map {
                
                $0.isEmpty ? "CARD_NUMBER_VALIDATION_ERROR".localizedString : ""
            }
        
        cardNumberValidation
            .asDriver()
            .map { $0 }
            .assign(to: \.cardNumberValidationMessage, on: output)
            .store(in: cancelBag)
        
        let cardNameValidation = Publishers
            .CombineLatest(output.$cardName, input.addCardTrigger)
            .map { $0.0 }
            .map {
                $0.isEmpty ? "CARD_NAME_VALIDATION_ERROR".localizedString : ""
            }
        
        cardNameValidation
            .asDriver()
            .map { $0 }
            .assign(to: \.cardNameValidationMessage, on: output)
            .store(in: cancelBag)
        
        Publishers
            .CombineLatest3(phoneNumberValidation, cardNumberValidation, cardNameValidation)
            .map { $0.0.isEmpty && $0.1.isEmpty && $0.2.isEmpty }
            .assign(to: \.isAddingEnabled, on: output)
            .store(in: cancelBag)
        
        input.addCardTrigger
            .delay(for: 0.1, scheduler: RunLoop.main)
            .filter { output.isAddingEnabled }
            .map {
                self.addCardUseCase.addCard(output.cardNumber)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink { bool in
                if bool {
                    navigator.showModally(reason: .cardActivation(output.cardNumber), isModal: true) { bool in
                        if bool {
                            addCardUseCase.changeCardSettings(Card(id: 0, cardNumber: output.cardNumber, displayName: output.cardName, cardBackground: output.coloredCards[output.cardIndex].cardBackground, isMain: output.isMain))
                                .trackError(errorTracker)
                                .trackActivity(activityTracker)
                                .asDriver()
                                .sink { bool in
                                    if bool {
                                        navigator.popView()
                                    }
                                }
                                .store(in: cancelBag)
                        }
                    }
                }
            }
            .store(in: cancelBag)
        
        input.popViewControllerTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0 ) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
            
        
        return output
    }
}
