//
//  NewsViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Combine
import Foundation
struct NewsViewModel {
    let navigator: NewsNavigatorType
    let useCase: NewsUseCaseType
}

extension NewsViewModel: ViewModel {
    struct Input {
        let selectNewsTrigger: Driver<NewsItemViewModel>
        let loadNewsTrigger: Driver<Void>
        let reloadNewsTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var news = [NewsItemViewModel]()
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var alert = AlertMessage()
        @Published var isEmpty = false
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.loadNewsTrigger.sink {}
        .store(in: cancelBag)
        
        let getPageInput = GetPageInput(loadTrigger: input.loadNewsTrigger,
                                        reloadTrigger: input.reloadNewsTrigger,
                                        loadMoreTrigger: input.loadMoreTrigger,
                                        getItems: useCase.getNews)
        
        let (page, error, isLoading, isReloading, isLoadingMore) = getPage(input: getPageInput).destructured
        
        page
            .map { $0.items.map { NewsItemViewModel(id: $0.id, date: $0.date, title: $0.title, shortContent: $0.shortContent, htmlContent: $0.htmlContent, imageUrl: $0.imageUrl)} }
            .assign(to: \.news, on: output)
            .store(in: cancelBag)
            
        error
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        isLoading
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        isReloading
            .assign(to: \.isReloading, on: output)
            .store(in: cancelBag)
        
        isLoadingMore
            .assign(to: \.isLoadingMore, on: output)
            .store(in: cancelBag)
        
        input.selectNewsTrigger
            .sink { item in
                navigator.showDetail(item)
            }
            .store(in: cancelBag)
        
        
        return output
    }
}
