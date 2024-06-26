//
//  CreateViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 06/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import Combine
struct SearchProductViewModel {
    let navigator: SearchProductViewNavigatorType
    let useCase: SearchProductViewUseCaseType
    let loadProductsTrigger = PassthroughSubject<String,Never>()
}

extension SearchProductViewModel: ViewModel {
    struct Input {
        let loadProductsTrigger: Driver<String>
        let reloadProductsTrigger: Driver<String>
        let loadMoreProductsTrigger: Driver<String>
        let showProductDetailView: Driver<ProductWithName>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var alert = AlertMessage()
        @Published var items = [ProductWithName]()
        @Published var hasMorePages = false
        @Published var searchedText = ""
        @Published var debounceText = ""
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        let getPageInfo = GetPageInput(loadTrigger: loadProductsTrigger.asDriver(), reloadTrigger: input.reloadProductsTrigger, loadMoreTrigger: input.loadMoreProductsTrigger, getItems: useCase.getProductsList)
        
        let (page,error,isLoading,isReloading,isLoadingMore) = getPage(input: getPageInfo).destructured
        
        page
            .handleEvents(receiveOutput:{
                pagingInfo in
                output.hasMorePages = pagingInfo.hasMorePages
            })
            .map { $0.items.map{ $0 } }
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
            .assign(to: \.isReloading, on: output)
            .store(in: cancelBag)
        
        isLoadingMore
            .assign(to: \.isLoadingMore, on: output)
            .store(in: cancelBag)
        
        input.loadProductsTrigger.sink { _ in
            guard output.debounceText != output.searchedText && !output.searchedText.isEmpty else { return }
            output.items = []
            output.debounceText = output.searchedText
            
            loadProductsTrigger.send(output.searchedText)
        }
        .store(in: cancelBag)
        
        output.$searchedText
            .debounce(for: .seconds(2.5), scheduler: RunLoop.main)
            .sink(receiveValue: { text in
                guard output.debounceText != text && !text.isEmpty else { return }
                output.items = []
                output.debounceText = text
                
                loadProductsTrigger.send(text)
            })
            .store(in: cancelBag)
        
        input.showProductDetailView
            .sink { model in
                navigator.showProductDealersListView(model: model)
            }
            .store(in: cancelBag)
        
        return output
    }
}
