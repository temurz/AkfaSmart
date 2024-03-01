//
//  ProductDealerListViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct ProductDealersListViewModel {
    let useCase: ProductDealersListViewUseCaseType
}

extension ProductDealersListViewModel: ViewModel {
    struct Input {
        let loadProductDealersTrigger: Driver<ProductDealersListInput>
        let reloadProductDealersTrigger: Driver<ProductDealersListInput>
        let loadMoreProductDealersTrigger: Driver<ProductDealersListInput>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var alert = AlertMessage()
        @Published var items = [ProductDealerWithLocation]()
        @Published var hasMorePages = false
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        let getPageInfo = GetPageInput(loadTrigger: input.loadProductDealersTrigger, reloadTrigger: input.reloadProductDealersTrigger, loadMoreTrigger: input.loadMoreProductDealersTrigger, getItems: useCase.getProductDealers)
        
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
        
        return output
    }
}
