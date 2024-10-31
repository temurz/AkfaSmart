//
//  CardsMainViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 28/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct CardsMainViewModel {
    let navigator: CardsMainViewNavigatorType
    let getCardsUseCase: GetCardsViewUseCaseType
    let deleteCardUseCase: DeleteCardUseCaseType
}

extension CardsMainViewModel: ViewModel {
    
    struct Input {
        let getCardsTrigger: Driver<Void>
        let showAddCardViewTrigger: Driver<Void>
        let selectCardTrigger: Driver<Card>
        let popViewControllerTrigger: Driver<Void>
        let deleteCardTrigger: Driver<Int>
    }
    
    final class Output: ObservableObject {
        @Published var cards = [Card]()
        @Published var isLoading = false
        @Published var alert = AlertMessage()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        
        input.getCardsTrigger
            .map {
                getCardsUseCase.getCards(nil)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { cards in
                output.cards = cards
            })
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
        
        input.popViewControllerTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)
        
        input.showAddCardViewTrigger
            .sink {
                navigator.showAddCardView()
            }
            .store(in: cancelBag)
        
        input.deleteCardTrigger
            .sink { id in
                deleteCardUseCase.deleteCard(id: id)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { bool in
                        if bool {
                            output.cards.removeAll { card in
                                card.id == id
                            }
                        }
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        input.selectCardTrigger
            .sink { card in
                navigator.showCardSettingsView(card)
            }
            .store(in: cancelBag)
        
        return output
    }
}
