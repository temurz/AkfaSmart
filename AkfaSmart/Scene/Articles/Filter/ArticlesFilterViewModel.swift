//
//  ArticleFilterViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 07/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct ArticlesFilterViewModel {
    let useCase: ArticleTypeViewUseCaseType
}

extension ArticlesFilterViewModel: ViewModel {
    struct Input {
        let getArticleTypesTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var types = [ArticleType]()
        @Published var isLoading = false
        @Published var selectedType = ArticleType(id: 3, name: "Каталог", parentId: nil, parentName: nil, hasChild: false)
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.getArticleTypesTrigger
            .sink {
                useCase.getArticleTypes()
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { types in
                        output.types = types
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
