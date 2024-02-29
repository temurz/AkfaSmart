//
//  ClassDetailViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct ClassDetailViewModel {
    let useCase: ClassDetailViewUseCaseType
}

extension ClassDetailViewModel: ViewModel {
    struct Input {
        let requestClassDetailsTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var details = [MobileClassDetail]()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.requestClassDetailsTrigger
            .map {
                useCase.getClassDetail()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { items in
                output.details = items
            })
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
            
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
