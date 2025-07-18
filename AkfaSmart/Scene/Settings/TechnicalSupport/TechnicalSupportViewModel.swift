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
    let navigator: PopViewNavigatorType
}

extension TechnicalSupportViewModel: ViewModel {
    struct Input {
        let loadMessagesTrigger: Driver<Void>
        let reloadMessagesTrigger: Driver<Void>
        let loadMoreMessagesTrigger: Driver<Void>
        let clearHistoryTrigger: Driver<Void>
        let sendMessageTrigger: Driver<String>
        let sendMessageWithImageTrigger: Driver<MessageWithData>
        let popViewControllerTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var hasMorePages = false
        @Published var alert = AlertMessage()
        @Published var items = [MessageModel]()
        @Published var isFirstLoad = true
        @Published var newMessages = 0
        @Published var isLoadingFile = false
        @Published var selectedImageData: Data?
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
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
            .map {
                if let error = $0 as? APIUnknownError, error.error == "Not Found".localizedString {
                    output.hasMorePages = false
                    return AlertMessage()
                }else {
                    return AlertMessage(error: $0)
                }
            }
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
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)

        
        input.clearHistoryTrigger
            .sink {
                useCase.clearHistory()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { bool in
                        if bool {
                            output.items = []
                        }
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        input.sendMessageTrigger
            .sink { text in
                useCase.sendMessage(message: MessageWithData(text: text, data: nil))
                    .asDriver()
                    .sink { message in
                        output.items.append(message)
                        output.newMessages += 1
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        input.sendMessageWithImageTrigger
            .sink { message in
                useCase.sendMessage(message: message)
                    .asDriver()
                    .sink { message in
                        output.items.append(message)
                        output.newMessages += 1
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        input.popViewControllerTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)
        
        return output
    }
}

struct MessageWithData {
    let text: String
    let data: Data?
}
