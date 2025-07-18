//
//  PromotionsListViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 18/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import Combine

struct PromotionsListViewModel {
    let promotions: [Promotion]
    let navigator: PromotionsListNavigatorType
}

extension PromotionsListViewModel: ViewModel {
    struct Input {
        let popViewTrigger: AnyPublisher<Void,Never>
        let selectPromotionTrigger: AnyPublisher<Promotion,Never>
    }
    
    final class Output: ObservableObject {
        let promotions: [Promotion]
        
        init(promotions: [Promotion]) {
            self.promotions = promotions
        }
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output(promotions: promotions)
        
        input.popViewTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)
        
        input.selectPromotionTrigger
            .sink { promotion in
                navigator.showPromotionDetailView(promotion: promotion)
            }
            .store(in: cancelBag)
        
        return output
    }
}
