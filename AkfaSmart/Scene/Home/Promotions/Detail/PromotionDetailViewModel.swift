//
//  PromotionDetailViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 14/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import Combine
import UIKit

struct PromotionDetailViewModel {
    let promotion: Promotion
    let navigator: PromotionDetailNavigatorType
}

extension PromotionDetailViewModel: ViewModel {
    
    struct Input {
        let popViewTrigger: AnyPublisher<Void,Never>
        let myCouponsTrigger: AnyPublisher<Void,Never>
    }
    
    final class Output: ObservableObject {
        let promotion: Promotion
        
        init(promotion: Promotion) {
            self.promotion = promotion
        }
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output(promotion: self.promotion)
        
        input.popViewTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)
        
        input.myCouponsTrigger
            .sink {
                navigator.showMyCouponsView()
            }
            .store(in: cancelBag)
        
        return output
    }
}
