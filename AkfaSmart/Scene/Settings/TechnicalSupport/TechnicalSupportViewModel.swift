//
//  TechnicalSupportViewModel.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 10/03/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation

struct TechnicalSupportViewModel {
    let useCase: TechnicalSupportUseCaseType
}

extension TechnicalSupportViewModel: ViewModel {
    struct Input {
        let loadMessagesTrigger: Driver<Void>
        let reloadMessagesTrigger: Driver<Void>
        let loadMoreMessagesTrigger: Driver<Void>
        
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var hasMorePages = false
        @Published var alert = AlertMessage()
        @Published var items = [MessageModel]()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        let getPageInput = GetPageInput(loadTrigger: input.loadMessagesTrigger, reloadTrigger: input.reloadMessagesTrigger, loadMoreTrigger: input.loadMoreMessagesTrigger, getItems: useCase.getMessages(page:))
        
        let (pages, error, isLoading, isReloading, isLoadingMore) = getPage(input: getPageInput).destructured
        
        pages
            .handleEvents(receiveOutput: { pagingInfo in
                output.hasMorePages = pagingInfo.hasMorePages
            })
            .map { $0.items.reversed() }
            .assign(to: \.items, on: output)
            .store(in: cancelBag)
        
        error
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0)}
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
            
        isLoading
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        isReloading
            .map({ bool in
                if bool {
                    output.items = []
                }
                return bool
            })
            .assign(to: \.isReloading, on: output)
            .store(in: cancelBag)
        
        isLoadingMore
            .assign(to: \.isLoadingMore, on: output)
            .store(in: cancelBag)

        
        
        return output
    }
}
