//
//  String + Extension.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 18.01.2025.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localizeWithFormat(arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}
