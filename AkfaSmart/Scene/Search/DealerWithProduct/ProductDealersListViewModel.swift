//
//  ProductDealerListViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import UIKit
struct ProductDealersListViewModel {
    let useCase: ProductDealersListViewUseCaseType
}

extension ProductDealersListViewModel: ViewModel {
    struct Input {
        let loadProductDealersTrigger: Driver<ProductDealersListInput>
        let reloadProductDealersTrigger: Driver<ProductDealersListInput>
        let loadMoreProductDealersTrigger: Driver<ProductDealersListInput>
        let showLocationTrigger: Driver<Location>
        let showPhoneCallTrigger: Driver<String>
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
            .map {
                if let error = $0 as? APIUnknownError, error.error == "Not Found".localizedString {
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
        
        input.showLocationTrigger.sink { location in
            openGoogleMap(lat: location.latitude, long: location.longitude)
        }
        .store(in: cancelBag)
        
        input.showPhoneCallTrigger.sink { phoneNumber in
            print("Call")
            openPhoneCall(phoneNumber)
        }
        .store(in: cancelBag)
        
        return output
    }
    
    func openGoogleMap(lat: Double, long: Double) {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
            if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
                UIApplication.shared.open(url, options: [:])
            }
        }
        else {
            //Open in browser
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination)
            }
        }
    }
    
    func openPhoneCall(_ phoneNumber: String) {
        let numbers = phoneNumber.components(separatedBy: ",")
        if let num = numbers.first {
            if let url = URL(string: "tel://\(num)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
    }
}

struct Location {
    let latitude: Double
    let longitude: Double
}
