//
//  AnyCodingKey.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 28.08.2024.
//

import Foundation

// MARK: - AnyCodingKey
struct AnyCodingKey: CodingKey {
    
    var stringValue: String
    var intValue: Int?

    init(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }

    init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
}
