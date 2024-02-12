//
//  AddDealerViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct AddDealerViewModel {
    let navigator: AddDealerNavigatorType
    let useCase: AddDealerUseCaseType
}

extension AddDealerViewModel: ViewModel {
    struct Input {
        let addDealerTrigger: Driver<Void>
        let showQRScannerTrigger: Driver<Bool>
        let showMainView: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var isShowingQrScanner = false
        @Published var isConfirmEnabled = false
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.showQRScannerTrigger
            .map { $0 }
            .assign(to: \.isShowingQrScanner, on: output)
            .store(in: cancelBag)
        
        input.showMainView.sink { _ in
            navigator.showMain()
        }
        .store(in: cancelBag)
        
        input.addDealerTrigger.sink { _ in
            useCase
        }
        .store(in: cancelBag)
        
        return output
    }
}
