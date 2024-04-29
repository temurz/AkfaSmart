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
        let addDealerTrigger: Driver<AddDealer>
        let searchDealerTrigger: Driver<Void>
        let showQRScannerTrigger: Driver<Bool>
        let showMainView: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var isShowingQrScanner = false
        @Published var isConfirmEnabled = false
        @Published var qrCodeValue = ""
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var addDealer: AddDealer?
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
        
        input.searchDealerTrigger.map { _ in
            useCase.sendQRCode(output.qrCodeValue)
                .trackError(errorTracker)
                .trackActivity(activityTracker)
                .asDriver()
        }
        .switchToLatest()
        .sink(receiveValue: { dealer in
            output.isConfirmEnabled = true
            output.addDealer = dealer
            output.qrCodeValue = ""
        })
        .store(in: cancelBag)
        
        input.addDealerTrigger
            .sink { dealer in
                useCase.requestSMSCode(dealer)
                    .trackActivity(activityTracker)
                    .trackError(errorTracker)
                    .asDriver()
                    .map { bool in
                        if bool {
                            navigator.showCodeInput(reason: .dealer(dealer, activeUsername: nil, isActive: false))
                        }else {
                            useCase.requestSMSCodeForActiveDealer(dealer)
                                .trackError(errorTracker)
                                .trackActivity(activityTracker)
                                .asDriver()
                                .map { dealerInfo in
                                    navigator.showCodeInput(reason: .dealer(dealer, activeUsername: dealerInfo.username, isActive: true))
                                }
                                .sink()
                                .store(in: cancelBag)
                        }
                    }
                    .sink()
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map { 
                if let error = $0 as? APIUnknownError, error.status == 702 {
                    if let dealer = output.addDealer {
                        useCase.requestSMSCodeForActiveDealer(dealer)
                            .trackError(errorTracker)
                            .trackActivity(activityTracker)
                            .asDriver()
                            .map { dealerInfo in
                                navigator.showCodeInput(reason: .dealer(dealer, activeUsername: dealerInfo.username, isActive: true))
                            }
                            .sink()
                            .store(in: cancelBag)
                    }
                    return AlertMessage()
                }else {
                    return AlertMessage(error: $0)
                }
            }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
            
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
