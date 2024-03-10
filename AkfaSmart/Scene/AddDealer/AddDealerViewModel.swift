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
        @Published var qrCodeValue = ""
        var addDealer: AddDealer?
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.showQRScannerTrigger
            .map { $0 }
            .assign(to: \.isShowingQrScanner, on: output)
            .store(in: cancelBag)
        
        input.showMainView.sink { _ in
            navigator.showMain(page: .home)
        }
        .store(in: cancelBag)
        
        input.addDealerTrigger
            .map { _ in
                useCase.sendQRCode(output.qrCodeValue)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { addDealer in
                useCase.requestSMSCode(addDealer)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
                    .map { bool in
                        if bool {
                            navigator.showCodeInput(reason: .dealer(addDealer))
                        }
                    }
                    .sink()
                    .store(in: cancelBag)
                output.addDealer = addDealer
            })
            .store(in: cancelBag)
        
        return output
    }
}
