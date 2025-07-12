//
//  Settings.swift
//  AkfaSmart
//
//  Created by Temur on 12/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//
import Foundation
struct Settings {
    
    static var isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
    
    static var isDebugOrTestFlight: Bool {
        if isTestFlight {
            return true
        }
        
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
}
