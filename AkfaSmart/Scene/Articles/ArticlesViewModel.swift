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
    }
    
    final class Output: ObservableObject {
        @Published var articles = [
            ArticleItemViewModel(id: 0, date: "2023-03-27T19:00:00.000+00:00", title: "Tiara TwinMax", shortContent: "Алюминиевые окна и двери", htmlContent: "", imageUrl: "http://84.54.75.248:1030/api/mobile/article/img/c6e6e4c7-9749-4861-97f0-37cb9e2ea6f6_twin.png", type: "Каталог", buttonColor: "#007AFF", fileUrls: []),
            ArticleItemViewModel(id: 1, date: "2023-03-27T19:00:00.000+00:00", title: "Tiara TwinMax", shortContent: "Алюминиевые окна и двери", htmlContent: "", imageUrl: "http://84.54.75.248:1030/api/mobile/article/img/c6e6e4c7-9749-4861-97f0-37cb9e2ea6f6_twin.png", type: "Каталог", buttonColor: "#007AFF", fileUrls: []),
        ]
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var alert = AlertMessage()
        @Published var isEmpty = false
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.showDetailViewTrigger
            .sink { item in
                navigator.showArticleDetail(item)
            }
            .store(in: cancelBag)
        
        return output
    }
}
