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
}

extension HomeViewModel: ViewModel {
    struct Input {
        
    }
    
    final class Output: ObservableObject {
        @Published var visible: Bool = AuthApp.shared.visibility
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        return output
    }
}
