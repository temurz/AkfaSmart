//
//  MarketinggraphicsViewModel.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//


import Foundation
struct MarketingGraphicsViewModel {
    let useCase: MarketingGraphicsViewUseCaseType
    let navigator: PopViewNavigatorType
}

extension MarketingGraphicsViewModel: ViewModel {
    struct Input {
        let requestMarketingGraphicsTrigger: Driver<Void>
        let popViewControllerTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var graphics: MarketingGraphics? = nil
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.requestMarketingGraphicsTrigger
            .map {
                useCase.getMarketingGraphics()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { marketingGraphics in
                output.graphics = marketingGraphics
            })
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0)}
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
        
        return output
    }
}
