//
//  APIServiceBase.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/30/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Alamofire
import Combine
import UIKit
import Foundation

public typealias JSONDictionary = [String: Any]
public typealias JSONArray = [JSONDictionary]
public typealias ResponseHeader = [AnyHashable: Any]

public protocol JSONData {
    init()
    static func equal(left: JSONData, right: JSONData) -> Bool
}

extension JSONDictionary: JSONData {
    public static func equal(left: JSONData, right: JSONData) -> Bool {
        // swiftlint:disable:next force_cast
        NSDictionary(dictionary: left as! JSONDictionary).isEqual(to: right as! JSONDictionary)
    }
}

extension JSONArray: JSONData {
    public static func equal(left: JSONData, right: JSONData) -> Bool {
        let leftArray = left as! JSONArray  // swiftlint:disable:this force_cast
        let rightArray = right as! JSONArray  // swiftlint:disable:this force_cast
        
        guard leftArray.count == rightArray.count else { return false }
        
        for i in 0..<leftArray.count {
            if !JSONDictionary.equal(left: leftArray[i], right: rightArray[i]) {
                return false
            }
        }
        
        return true
    }
}

open class APIBase {
    
    public var manager: Alamofire.Session
    public var logOptions = LogOptions.default
    private let cancelBag = CancelBag()
    
    public convenience init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        configuration.httpCookieStorage = nil
        self.init(configuration: configuration)
    }
    
    public init(configuration: URLSessionConfiguration) {
        manager = Alamofire.Session(configuration: configuration)
    }
    
    open func requestImage(_ input: APIInputBase) -> AnyPublisher<Data, Error> {
        if let token = AuthApp.shared.token, input.requireAccessToken {
            if input.headers == nil {
                input.headers = HTTPHeaders()
            }
            input.headers?.add(name: "Authorization", value: "Bearer " + token)
        }
        
        return Future<Data, Error> { promise in
            AF.request(input.urlString, headers: input.headers).responseData { response in
                switch response.result {
                case .success(let data):
                        promise(.success(data))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    open func success(_ input: APIInputBase) -> AnyPublisher<APIResponse<Bool>, Error> {
        let response: AnyPublisher<APIResponse<JSONDictionary>, Error> = requestJSON(input)
        let appResponce: AnyPublisher<APIResponse<JSONDictionary>,Error> = postProcess(response)
        return appResponce
            .tryMap { apiResponse -> APIResponse<Bool> in
               
                    let jsonData = apiResponse.data
                    return APIResponse(header: apiResponse.header, data: jsonData["success"] as? Bool ?? true)
            
            }
            .eraseToAnyPublisher()
    }
    
    open func success(_ input: APIInputBase) -> AnyPublisher<Bool, Error> {
        success(input)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    open func successPrimitive(_ input: APIInputBase) -> AnyPublisher<APIResponse<Bool>, Error> {
        let response: AnyPublisher<APIResponse<JSONDictionary>, Error> = requestJSON(input)
        return response
            .tryMap { (apiResponse) -> APIResponse<Bool> in
               
                    let json = apiResponse.data
                    let success = json["success"] as? Bool ?? false
//                    let object = json["body"] as? T
                    if success {
                        return APIResponse(header: apiResponse.header,
                                           data: success)
                    }
                    else {
                        throw self.handleResponseError( json:  json)
                    }
                    
               
            }
            .eraseToAnyPublisher()
    }
    
    open func successPrimitive(_ input: APIInputBase) -> AnyPublisher<Bool, Error> {
        successPrimitive(input)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    open func request<T: Decodable>(_ input: APIInputBase) -> AnyPublisher<APIResponse<T>, Error> {
        let response: AnyPublisher<APIResponse<JSONDictionary>, Error> = requestJSON(input)
        let appResponce: AnyPublisher<APIResponse<JSONDictionary>,Error> = postProcess(response)
        return appResponce
            .tryMap { apiResponse -> APIResponse<T> in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: apiResponse.data,
                                                              options: [])
                    let t = try JSONDecoder().decode(T.self, from: jsonData)
                    return APIResponse(header: apiResponse.header, data: t)
                } catch {
                    throw APIInvalidResponseError()
                }
            }
            .eraseToAnyPublisher()
    }
    
    open func request<T: Decodable>(_ input: APIInputBase) -> AnyPublisher<T, Error> {
        request(input)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    open func requestPrimitive<T: Decodable>(_ input: APIInputBase) -> AnyPublisher<APIResponse<T>, Error> {
        let response: AnyPublisher<APIResponse<JSONDictionary>, Error> = requestJSON(input)
        return response
            .tryMap { (apiResponse) -> APIResponse<T> in
               
                    let json = apiResponse.data
                    let success = json["success"] as? Bool ?? false
                    let object = json["body"] as? T
                    if success && object != nil{
                        return APIResponse(header: apiResponse.header,
                                           data: object!)
                    }
                    else {
                        throw self.handleResponseError( json:  json)
                    }
                    
               
            }
            .eraseToAnyPublisher()
    }
    
    open func requestPrimitive<T: Decodable>(_ input: APIInputBase) -> AnyPublisher<T, Error> {
        requestPrimitive(input)
            .map { $0.data }
            .eraseToAnyPublisher()
    }

    open func requestList<T: Decodable>(_ input: APIInputBase) -> AnyPublisher<APIResponse<[T]>, Error> {
        let response: AnyPublisher<APIResponse<JSONDictionary>, Error> = requestJSON(input)
        let appResponce: AnyPublisher<APIResponse<JSONArray>,Error> = postProcess(response)
        return appResponce
            .tryMap { apiResponse -> APIResponse<[T]> in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: apiResponse.data,
                                                              options: .prettyPrinted)

                    let items = try JSONDecoder().decode([T].self, from: jsonData)
                    return APIResponse(header: apiResponse.header,
                                       data: items)
                } catch {
                    throw APIInvalidResponseError()
                }
            }
            .eraseToAnyPublisher()
    }
    
    open func requestList<T: Decodable>(_ input: APIInputBase) -> AnyPublisher<[T], Error> {
        requestList(input)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    open func requestJSON<U: JSONData>(_ input: APIInputBase) -> AnyPublisher<APIResponse<U>, Error> {
        
        let urlRequest = preprocess(input)
            .handleEvents(receiveOutput: { [unowned self] input in
                if self.logOptions.contains(.request) {
                    print(input.description(isIncludedParameters: self.logOptions.contains(.requestParameters)))
                }
            })
            .map { [unowned self] input -> DataRequest in
                let request: DataRequest
                
                if let token = AuthApp.shared.token, input.requireAccessToken {
                    if input.headers == nil {
                        input.headers = HTTPHeaders()
                    }
                    input.headers?.add(name: "Authorization", value: "Bearer " + token)
                }
                
                if let uploadInput = input as? APIUploadInputBase {
                    request = self.manager.upload(
                        multipartFormData: { (multipartFormData) in
                            input.parameters?.forEach { key, value in
                                if let data = String(describing: value).data(using: .utf8) {
                                    multipartFormData.append(data, withName: key)
                                }
                            }
                            uploadInput.data.forEach({
                                multipartFormData.append(
                                    $0.data,
                                    withName: $0.name,
                                    fileName: $0.fileName,
                                    mimeType: $0.mimeType)
                            })
                        },
                        to: uploadInput.urlString,
                        method: uploadInput.method,
                        headers: uploadInput.headers
                    )
                } else {
                    request = self.manager.request(
                        input.urlString,
                        method: input.method,
                        parameters: input.parameters,
                        encoding: input.encoding,
                        headers: input.headers
                    )
                }
                
                return request
            }
            .handleEvents(receiveOutput: { (dataRequest) in
                if self.logOptions.contains(.rawRequest) {
                    debugPrint(dataRequest)
                }
            })
            .flatMap { dataRequest -> AnyPublisher<DataResponse<Data, AFError>, Error> in
                return dataRequest.publishData()
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .tryMap { (dataResponse) -> APIResponse<U> in
                return try self.process(dataResponse)
            }
            .tryCatch { [unowned self] error -> AnyPublisher<APIResponse<U>, Error> in
                return try self.handleRequestError(error, input: input)
            }
           
            .eraseToAnyPublisher()
        
        
        return  urlRequest
    }
    
    open func preprocess(_ input: APIInputBase) -> AnyPublisher<APIInputBase, Error> {
        Just(input)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    open func process<U: JSONData>(_ dataResponse: DataResponse<Data, AFError>) throws -> APIResponse<U> {
        let error: Error
        
        switch dataResponse.result {
        case .success(let data):
            let json: U? = (try? JSONSerialization.jsonObject(with: data, options: [])) as? U
            guard let statusCode = dataResponse.response?.statusCode else {
                throw APIUnknownError(statusCode: nil)
            }
            
            switch statusCode {
            case 200..<300:
                if logOptions.contains(.responseStatus) {
                    print("👍 [\(statusCode)] " + (dataResponse.response?.url?.absoluteString ?? ""))
                }
                
                if logOptions.contains(.dataResponse) {
                    print(dataResponse)
                }
                
                if logOptions.contains(.responseData) {
                    print("[RESPONSE DATA]")
                    print(json ?? data)
                }
                
                // swiftlint:disable:next explicit_init
                return APIResponse(header: dataResponse.response?.allHeaderFields, data: json ?? U.init())
            default:
                error = handleResponseError(dataResponse: dataResponse, json: json)
                
                if logOptions.contains(.responseStatus) {
                    print("❌ [\(statusCode)] " + (dataResponse.response?.url?.absoluteString ?? ""))
                }
                
                if logOptions.contains(.dataResponse) {
                    print(dataResponse)
                }
                
                if logOptions.contains(.error) || logOptions.contains(.responseData) {
                    print("[RESPONSE DATA]")
                    print(json ?? data)
                }
            }
            
        case .failure(let afError):
            guard let statusCode = dataResponse.response?.statusCode else {
                throw APIUnknownError(statusCode: nil)
            }
            if statusCode == 401 {
                API.shared.login(API.LoginInput(dto: LoginDto(username: AuthApp.shared.username ?? "", password: AuthApp.shared.pass ?? "")))
                    .map { output in
                        AuthApp.shared.token = output.remoteSession
                        AuthApp.shared.username = output.username
                    }
                    .sink()
                    .store(in: cancelBag)
                error = APIUnknownError(statusCode: 0, error: "PLEASE_TRY_AGAIN_ERROR".localizedString)
            } else {
                error = afError
            }
            
        }
        
        throw error
    }
    
    open func postProcess<U:JSONData>(_ response: AnyPublisher<APIResponse<JSONDictionary>, Error>)-> AnyPublisher<APIResponse<U>, Error>{
        return response
            .tryMap { (apiResponse) -> APIResponse<U> in
                
                let json = apiResponse.data
                let success = json["success"] as? Int ?? 0
                let object = json["body"] as? U
                if let body = json["body"] {
                    print("Type of json[\"body\"]: \(type(of: body))")
                }
                if success == 1 {
                    return APIResponse(header: apiResponse.header,
                                       data: object ?? U.init())
                } else {
                    throw self.handleResponseError( json:  json)
                }
                
                
            }
            .eraseToAnyPublisher()
    }
    
    open func handleRequestError<U: JSONData>(_ error: Error,
                                              input: APIInputBase) throws -> AnyPublisher<APIResponse<U>, Error> {
        throw error
    }
    
    open func handleRequestError<U: JSONData>(_ error: Error) throws -> AnyPublisher<APIResponse<U>, Error> {
        throw error
    }
    
    open func handleResponseError<U: JSONData>(dataResponse: DataResponse<Data, AFError>, json: U?) -> Error {
        if let jsonDictionary = json as? JSONDictionary {
            return handleResponseError(dataResponse: dataResponse, json: jsonDictionary)
        } else if let jsonArray = json as? JSONArray {
            return handleResponseError(dataResponse: dataResponse, json: jsonArray)
        }
        
        return handleResponseUnknownError(dataResponse: dataResponse)
    }
    
    open func handleResponseError(dataResponse: DataResponse<Data, AFError>, json: JSONDictionary?) -> Error {
        APIUnknownError(statusCode: dataResponse.response?.statusCode)
    }
    
    open func handleResponseError(json: JSONDictionary?) -> Error {
        APIUnknownError(statusCode: json?["code"] as? Int, error: json?["message"] as? String)
    }
    
    open func handleResponseError(dataResponse: DataResponse<Data, AFError>, json: JSONArray?) -> Error {
        APIUnknownError(statusCode: dataResponse.response?.statusCode)
    }
    
    open func handleResponseUnknownError(dataResponse: DataResponse<Data, AFError>) -> Error {
        APIUnknownError(statusCode: dataResponse.response?.statusCode)
    }
}
