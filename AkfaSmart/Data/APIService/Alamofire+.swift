//
//  Alamofire+.swift
//  AkfaSmart
//
//  Created by Temur on 28/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Alamofire
import Foundation

extension Alamofire.Session {
    @discardableResult
    public func requestWithoutCache(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)// also you can add URLRequest.CachePolicy here as parameter
        -> DataRequest
    {
        
        do {
            var urlRequest = try URLRequest(url: url, method: method, headers: headers)
         
           
            urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
            URLCache.shared.removeCachedResponse(for: urlRequest)
            
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            return request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
        }
    }
    
    public func simpleRequest(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil)// also you can add URLRequest.CachePolicy here as parameter
        -> DataRequest
    {
        let request = AF.request(url, method: method, parameters: parameters, headers: headers)
        return request
    }
}
