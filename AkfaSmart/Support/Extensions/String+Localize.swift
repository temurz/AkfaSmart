//
//  String+Localize.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
extension String {
    func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localizedString, arguments: arguments)
    }
    
    var localizedString: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }
}
