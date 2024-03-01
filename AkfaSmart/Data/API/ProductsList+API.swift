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
        init(text: String, dto: GetPageDto) {
            let params: Parameters = [
                "productName": text,
                "length": dto.perPage,
                "start": dto.page
            ]
            super.init(urlString: API.Urls.getProductsList, parameters: params, method: .post, requireAccessToken: true)
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
}
