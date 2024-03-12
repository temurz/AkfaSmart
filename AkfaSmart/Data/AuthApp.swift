//
//  AuthApp.swift
//  AkfaSmart
//
//  Created by Temur on 28/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
class AuthApp {
    static let shared: AuthApp = AuthApp()
    
    private var keyToken:String { "tokenKey" }
    private var keyAuth:String { "MyAutorizationKey"}
    private var keyAppEnterCode: String { "appEnterCodeKey" }
    private let keyFirstEnter: String = "firstEnter"
    private let keyForVisibility: String = "visibilityKey"
    private let keySMSCode: String = "SMSCodeKey"
    private let defaults = UserDefaults.standard
    
    //MARK: Token
    var token:String? {
        get {
//            guard let token = defaults.string(forKey: keyToken) else {return nil}
            //TODO:
            //Permanent token
            return /*token*/
            "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5OTg5NzU1MDA1NzUiLCJleHAiOjE3MDg5OTg4MDAsImlhdCI6MTcwODk5ODUwMH0.P4zGKTOHey-rdg7HuQLHX_7lJ22qm52h0dn9sw66thuVRw1fJld1NaDWmO4ZDzM7HJIwcwNreg0GUAG95nFdyA"
        }
        set {
            guard let _ = newValue else {return removeToken()}
            defaults.setValue(newValue, forKey: keyToken)
        }
    }
    
    //MARK: username
    var username: String? {
        get {
            guard let name = defaults.string(forKey: keyAuth) else {return nil}
            return name
        }
        set {
            defaults.setValue(newValue, forKey: keyAuth)
        }
    }
    
    var appEnterCode: String? {
        get {
            UserDefaults.standard.string(forKey: keyAppEnterCode)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: keyAppEnterCode)
        }
    }
    
    var smsCode: String? {
        get {
            defaults.string(forKey: keySMSCode)
        }
        set {
            defaults.setValue(newValue, forKey: keySMSCode)
        }
    }
    
    var visibility: Bool {
        get {
            defaults.bool(forKey: keyForVisibility)
        }
        set {
            defaults.setValue(newValue, forKey: keyForVisibility)
        }
    }
    
    //MARK: - Token Action
    func removeToken() {
        defaults.removeObject(forKey: keyToken)
    }
    
    private func removeAutorization() {
        defaults.removeObject(forKey: keyAuth)
    }
    
    //MARK: - Language
    var language: String {
        get {
            return UserDefaults.standard.string(forKey: "LanguageTypeKey") ?? "uz"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "LanguageTypeKey")
            UserDefaults.standard.synchronize()
        }
    }
    
    //MARK: - First Enter to App
    var isFirstEnter: Int {
        get {
            return UserDefaults.standard.integer(forKey: keyFirstEnter)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: keyFirstEnter)
            UserDefaults.standard.synchronize()
        }
    }
}

extension String {
    func makeStarsInsteadNumbersInUsername() -> String {
        //["+", "9","9","8"]        
        var text = Array(self)
        for i in 0 ..< text.count {
            if i >= 6 && i <= 9 {
                text[i] = "*"
            }
        }
        
        return String(text)
    }
}
