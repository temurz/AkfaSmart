//
//  HomeViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct HomeViewModel {
    let navigator: HomeViewNavigatorType
    let useCase: HomeViewUseCaseType
    let mobileClassUseCase: MobileClassUseCaseType
    let getCardsUseCase: GetCardsViewUseCaseType
}

extension HomeViewModel: ViewModel {
    struct Input {
        let getDealersTrigger: Driver<Void>
        let getMobileClassInfo: Driver<Void>
        let showAddDealerViewTrigger: Driver<Void>
        let showClassDetailViewTrigger: Driver<Void>
        let showMessagesViewTrigger: Driver<Void>
        let showArticlesViewTrigger: Driver<Void>
        let showNewsViewTrigger: Driver<Void>
        let getCardsTrigger: Driver<Void>
        let showDealerDetailsViewTrigger: Driver<Dealer>
        let showCardsMainViewTrigger: Driver<Void>
        let showMyDealersViewTrigger: Driver<Void>
        let addCardViewTrigger: Driver<Void>
        let cardSettingsViewTrigger: Driver<Card>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var hasDealers = false
        @Published var items: [Dealer] = [Dealer()]
        @Published var cards: [Card] = [Card()]
        @Published var currentDealerIndex = 0
        @Published var currentCardIndex = 0
        @Published var targetIndex: Int? = 0
        @Published var needToRender = false
        @Published var mobileClass: MobileClass? = nil
        @Published var mobileClassLogoData: Data? = nil
        @Published var unreadDataCount: UnreadDataCount = UnreadDataCount(countUnreadMessages: 0, countUnreadArticles: 0, countUnreadNews: 0)
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.showAddDealerViewTrigger.sink {
            navigator.showAddDealerView()
        }
        .store(in: cancelBag)
        
        input.getDealersTrigger
            .map { _ in
                useCase.checkHasADealer()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { bool in
                if bool {
                    useCase.getDealers()
                        .trackError(errorTracker)
                        .trackActivity(activityTracker)
                        .asDriver()
                        .map { dealers in
                            output.hasDealers = bool
                            output.items = dealers
                            output.items.append(Dealer())
                            output.needToRender.toggle()
                        }
                        .sink()
                        .store(in: cancelBag)
                }else {
                    output.items = [Dealer()]
                }
            }
            )
            .store(in: cancelBag)
        
        input.getMobileClassInfo
            .map {
                mobileClassUseCase.getMobileClassInfo()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { mobileClass in
                mobileClassUseCase.getMobileClassImage(mobileClass.logoImgUrl ?? "")
                    .asDriver()
                    .map { data in
                        output.mobileClassLogoData = data
                    }
                    .sink()
                    .store(in: cancelBag)
                output.mobileClass = mobileClass
            })
            .store(in: cancelBag)
        
        input.showClassDetailViewTrigger
            .sink {
                navigator.showClassDetailView(imageData: output.mobileClassLogoData, title: output.mobileClass?.klassName)
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
        
        input.showArticlesViewTrigger
            .sink {
                navigator.showMain(page: .catalog)
            }
            .store(in: cancelBag)
        
        input.showNewsViewTrigger
            .sink {
                navigator.showMain(page: .news)
            }
            .store(in: cancelBag)
        
        input.showMessagesViewTrigger
            .sink {
                navigator.showTechnicalSupport()
            }
            .store(in: cancelBag)
        
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
                output.cards.append(Card())
                output.needToRender.toggle()
            })
            .store(in: cancelBag)
        
        input.showDealerDetailsViewTrigger
            .sink { dealer in
                navigator.showDealersDetailViewModally(dealer: dealer)
            }
            .store(in: cancelBag)
        
        input.showCardsMainViewTrigger
            .sink {
                navigator.showCardsMainView()
            }
            .store(in: cancelBag)
        
        input.addCardViewTrigger
            .sink {
                navigator.showAddCardView()
            }
            .store(in: cancelBag)
        
        input.cardSettingsViewTrigger
            .sink { card in
                navigator.showCardSettingsView(card)
            }
            .store(in: cancelBag)
        
        input.showMyDealersViewTrigger
            .sink {
                navigator.showMyDealers(output.items.dropLast())
            }
            .store(in: cancelBag)
        
        return output
    }
}
