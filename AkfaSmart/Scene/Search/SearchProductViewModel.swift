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
        let showLocationTrigger: Driver<ProductWithName>
        let selectProductTrigger: Driver<ProductWithName>
        let addToCartTrigger: Driver<(ProductWithName, Int)>
        let dismissAddToCartTrigger: Driver<Void>
        let showCartTrigger: Driver<Void>
    }

    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var isLoadingMore = false
        @Published var alert = AlertMessage()
        @Published var items = [ProductWithName]()
        @Published var hasMorePages = false
        @Published var searchedText = ""
        @Published var debounceText: String?
        @Published var selectedProduct: ProductWithName?
        @Published var cartCount = 0
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
            guard output.debounceText != output.searchedText else { return }
            output.items = []
            output.debounceText = output.searchedText

            loadProductsTrigger.send(output.searchedText)
        }
        .store(in: cancelBag)

        output.$searchedText
            .debounce(for: .seconds(2.5), scheduler: RunLoop.main)
            .sink(receiveValue: { text in
                guard output.debounceText != text else { return }
                output.items = []
                output.debounceText = text

                loadProductsTrigger.send(text)
            })
            .store(in: cancelBag)
        
        input.showLocationTrigger
            .sink { model in
                navigator.showProductDealersListView(model: model)
            }
            .store(in: cancelBag)

        input.selectProductTrigger
            .sink { model in
                output.selectedProduct = model
            }
            .store(in: cancelBag)

        input.dismissAddToCartTrigger
            .sink {
                output.selectedProduct = nil
            }
            .store(in: cancelBag)

        input.addToCartTrigger
            .sink { model, quantity in
                output.selectedProduct = nil
                useCase.saveOrderItem(productId: model.id, quantity: quantity)
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            output.alert = AlertMessage(error: error)
                        }
                    }, receiveValue: { _ in
                        CartManager.shared.refreshCount()
                    })
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)

        input.showCartTrigger
            .sink {
                navigator.showCartView()
            }
            .store(in: cancelBag)

        CartManager.shared.$count
            .receive(on: RunLoop.main)
            .assign(to: \.cartCount, on: output)
            .store(in: cancelBag)

        CartManager.shared.refreshCount()

        return output
    }
}
