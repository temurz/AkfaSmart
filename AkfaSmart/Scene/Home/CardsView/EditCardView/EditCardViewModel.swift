//
//  EditCardViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 31/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Combine
import Foundation
struct EditCardViewModel {
    let model: Card
    let editCardUseCase: EditCardViewUseCaseType
    let settingCardUseCase: ChangeCardSettingsUseCaseType
    let deleteCardUseCase: DeleteCardUseCaseType
    let getCardUseCase: GetCardsViewUseCaseType
    let navigator: EditCardViewNavigatorType
}

extension EditCardViewModel: ViewModel {
    
    struct Input {
        let blockCardTrigger: Driver<Void>
        let saveChangesTrigger: Driver<Void>
        let deleteCardTrigger: Driver<Void>
        let getCardInfoTrigger: Driver<Void>
        let popViewControllerTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var card: Card
        @Published var isMain: Bool = false
        @Published var cardName = ""
        @Published var cardNameValidationMessage = ""
        
        init(card: Card) {
            self.card = card
            self.isMain = card.isMain ?? false
            self.cardName = card.displayName ?? ""
        }
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output(card: model)
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        
        let cardNameValidation = Publishers
            .CombineLatest(output.$cardName, input.saveChangesTrigger)
            .map { $0.0 }
            .map {
                $0.isEmpty ? "CARD_NAME_VALIDATION_ERROR".localizedString : ""
            }
        
        cardNameValidation
            .asDriver()
            .map { $0 }
            .assign(to: \.cardNameValidationMessage, on: output)
            .store(in: cancelBag)
        
        input.blockCardTrigger
            .sink {
                if output.card.isBlocked ?? false {
                    let connectedPhone = AuthApp.shared.username?.getOnlyNumbers()
                    editCardUseCase.unblock(id: output.card.id, connectedPhone: connectedPhone ?? "")
                        .trackError(errorTracker)
                        .trackActivity(activityTracker)
                        .asDriver()
                        .sink { bool in
                            if bool {
                                navigator.showModally(reason: .unblock(output.card.id, connectedPhone: connectedPhone ?? ""), isModal: true) { bool in
                                    if bool {
                                        output.card.block(false)
                                    }
                                }
                            }
                        }
                        .store(in: cancelBag)
                } else {
                    editCardUseCase.block(id: output.card.id)
                        .trackError(errorTracker)
                        .trackActivity(activityTracker)
                        .asDriver()
                        .sink { bool in
                            if bool {
                                navigator.showModally(reason: .block(output.card.id), isModal: true) { bool in
                                    if bool {
                                        output.card.block(true)
                                    }
                                }
                            }
                        }
                        .store(in: cancelBag)
                }
            }
            .store(in: cancelBag)
        
        input.deleteCardTrigger
            .sink {
                deleteCardUseCase.deleteCard(id: output.card.id)
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
            .store(in: cancelBag)
        
        input.saveChangesTrigger
            .delay(for: 0.1, scheduler: RunLoop.main)
            .filter { output.cardNameValidationMessage.isEmpty } 
            .sink {
                settingCardUseCase.changeCardSettings(output.card.newCopy(isMain: output.isMain, displayName: output.cardName))
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
