//
//  MyCouponsViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 18/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import Foundation
import Combine


struct MyCouponsViewModel {
    let useCase: MyCouponsViewUseCaseType
    let navigator: PopViewNavigatorType
}

extension MyCouponsViewModel: ViewModel {
    
    struct Input {
        let popViewTrigger: AnyPublisher<Void,Never>
        let onAppearTrigger: AnyPublisher<Void,Never>
    }
    
    class Output: ObservableObject {
        @Published var isLoading = false
        @Published var items = [CouponInfo]()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        let activityTracker = ActivityTracker(false)
        
        input.onAppearTrigger
            .sink {
                useCase.getPromotionsList()
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { items in
                        output.items = items
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        input.popViewTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)
        
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
