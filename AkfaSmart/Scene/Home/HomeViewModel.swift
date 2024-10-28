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
    }
    
    final class Output: ObservableObject {
        @Published var visible: Bool = AuthApp.shared.visibility
        @Published var totalOfMonth = 0.0
        @Published var totalOfYear = 0.0
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var hasDealers = false
        @Published var items: [Dealer] = []
        @Published var cards: [Card] = []
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
                            output.totalOfMonth = dealers
                                .map { $0.purchaseForMonth }
                                .reduce(0,+)
                            
                            output.totalOfYear = dealers
                                .map {$0.purchaseForYear}
                                .reduce(0, +)
                            
                            output.hasDealers = bool
                            output.items = dealers
                        }
                        .sink()
                        .store(in: cancelBag)
                }else {
                    output.items = []
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
        
        return output
    }
}
