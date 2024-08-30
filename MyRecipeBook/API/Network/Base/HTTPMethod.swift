//
//  HTTPMethod.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import Foundation

// MARK: - HTTPMethod
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    
    var allowsBody: Bool {
        switch self {
        case .get:
            return false
        case .post:
            return true
        }
    }
}
