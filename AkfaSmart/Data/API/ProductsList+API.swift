//
//  Products+API.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Alamofire
extension API {
    func getProducts(_ input: GetProductsListInput) -> Observable<[ProductWithName]> {
        requestList(input)
    }
    
    final class GetProductsListInput: APIInput {
        init(text: String, groupId: Int?, dto: GetPageDto) {
            var params: Parameters = [
                "length": dto.perPage,
                "start": dto.page
            ]
            if !text.isEmpty {
                params["search"] = text
            }
            if let groupId {
                params["groupId"] = groupId
            }
            super.init(urlString: API.Urls.getProductsList, parameters: params, method: .get, requireAccessToken: true)
        }
    }
}

extension API {
    func getProductGroupTree(_ input: GetProductGroupTreeInput) -> Observable<[ProductGroup]> {
        requestList(input)
    }

    final class GetProductGroupTreeInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getProductGroupTree, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}

extension API {
    func getProductDealers(_ input: GetProductDealersListInput) -> Observable<[ProductDealerWithLocation]> {
        requestList(input)
    }
    
    final class GetProductDealersListInput: APIInput {
        init(dto: GetPageDto, input: ProductDealersListInput) {
            let params: Parameters = [
                "productName": input.productName,
                "latitude": input.latitude,
                "longitude": input.longitude,
                "length": dto.perPage,
                "start": dto.page
            ]
            super.init(urlString: API.Urls.getProductsListByNameAndLocation, parameters: params, method: .post, requireAccessToken: true)
        }
    }
    
    func getProductDealersById(_ input: GetProductDealersByIdInput) -> Observable<[ProductDealerWithLocation]> {
        requestList(input)
    }
    
    final class GetProductDealersByIdInput: APIInput {
        init(dto: GetPageDto, input: ProductDealersByIdInput) {
            let params: Parameters = [
                "productId": input.productId,
                "latitude": input.latitude,
                "longitude": input.longitude,
                "length": dto.perPage,
                "start": dto.page
            ]
            super.init(urlString: API.Urls.getProductDealersListById, parameters: params, method: .post, requireAccessToken: true)
        }
    }
}
