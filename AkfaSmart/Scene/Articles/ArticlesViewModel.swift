//
//  ArticlesViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct ArticlesViewModel {
    let navigator: ArticlesNavigatorType
    let useCase: ArticlesUseCaseType
}

extension ArticlesViewModel: ViewModel {
    
    struct Input {
        let showDetailViewTrigger: Driver<ArticleItemViewModel>
        let loadArticlesTrigger: Driver<Void>
        let reloadNewsTrigger: Driver<Void>
        let loadMoreArticlesTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var articles = [ArticleItemViewModel]()
        @Published var isLoading = true
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var alert = AlertMessage()
        @Published var isEmpty = false
        @Published var hasMorePages = false

    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.showDetailViewTrigger
            .sink { item in
                navigator.showArticleDetail(item)
            }
            .store(in: cancelBag)
        
//        input.loadArticlesTrigger.sink{}
//            .store(in: cancelBag)
        
        let getPageInput = GetPageInput(loadTrigger: input.loadArticlesTrigger, reloadTrigger: input.reloadNewsTrigger, loadMoreTrigger: input.loadMoreArticlesTrigger, getItems: useCase.getArticles)
        
        let (pages, error, isReloading, isLoading, isLoadingMore) = getPage(input: getPageInput).destructured
        
        pages
            .handleEvents(receiveOutput: { pagingInfo in
                output.hasMorePages = pagingInfo.hasMorePages
            })
            .map { $0.items }
            .assign(to: \.articles, on: output)
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
            .assign(to: \.isReloading, on: output)
            .store(in: cancelBag)
        
        isLoadingMore
            .assign(to: \.isLoadingMore, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
