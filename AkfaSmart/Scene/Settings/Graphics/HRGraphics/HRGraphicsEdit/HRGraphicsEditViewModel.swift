//
//  HRGraphicsEditViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct HRGraphicsEditViewModel {
    let useCase: HRGraphicsEditViewUseCaseType
    let navigator: PopViewNavigatorType
}

extension HRGraphicsEditViewModel: ViewModel {
    struct Input {
        
    }
    
    final class Output {
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        
        
        
        
        return output
    }
}
