//
//  APIErrorBase.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/30/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Foundation

public protocol APIError: LocalizedError {
    var statusCode: Int? { get }
}

public extension APIError {  // swiftlint:disable:this no_extension_access_modifier
    var statusCode: Int? { return nil }
}

public struct APIInvalidResponseError: APIError {
    
    public init() {
        
    }
    
    public var errorDescription: String? {
        return NSLocalizedString("api.invalidResponseError",
                                 value: "Invalid server response",
                                 comment: "")
    }
}

public struct APIUnknownError: APIError {
    
    public let status: Int?
    public let timestamp: String?
    public let path: String?
    public let error: String?
    
    public init(statusCode: Int?) {
        self.status = statusCode
        self.error = ""
        self.path = ""
        self.timestamp = ""
//        self.init(statusCode: statusCode, error: NSLocalizedString("api.unknownError",
//                            value: "Unknown API error",
//                            comment: ""))
    }
    
    public init(statusCode: Int?, error: String?){
        self.status = statusCode
        self.error = error
        self.path = ""
        self.timestamp = ""
    }
    
    public init(statusCode: Int?, error: String?, path: String?, timestamp: String?){
        self.status = statusCode
        self.error = error
        self.path = path
        self.timestamp = timestamp
    }
}
