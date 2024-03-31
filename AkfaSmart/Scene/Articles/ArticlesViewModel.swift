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
        let loadArticlesTrigger: Driver<ArticlesGetInput>
        let reloadArticlesTrigger: Driver<ArticlesGetInput>
        let loadMoreArticlesTrigger: Driver<ArticlesGetInput>
        let showFilterViewTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var articles = [ArticleItemViewModel]()
        @Published var isFirstLoad = true
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var alert = AlertMessage()
        @Published var isEmpty = false
        @Published var hasMorePages = false
        @Published var dateFilter = DateFilter()
        @Published var articleType = ArticleObservableType()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.showDetailViewTrigger
            .sink { item in
                navigator.showArticleDetail(item)
            }
            .store(in: cancelBag)
        
        input.showFilterViewTrigger.sink {
            navigator.showArticlesFilterView(output.dateFilter, output.articleType)
        }
        .store(in: cancelBag)
        
        let getPageInput = GetPageInput(loadTrigger: input.loadArticlesTrigger, reloadTrigger: input.reloadArticlesTrigger, loadMoreTrigger: input.loadMoreArticlesTrigger, getItems: useCase.getArticles)
        
        let (pages, error, isLoading, isReloading, isLoadingMore) = getPage(input: getPageInput).destructured
        
        pages
            .handleEvents(receiveOutput: { pagingInfo in
                output.hasMorePages = pagingInfo.hasMorePages
            })
            .map { $0.items }
            .assign(to: \.articles, on: output)
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
                    output.articles = []
                }
                return bool
            })
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        isLoadingMore
            .assign(to: \.isLoadingMore, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
