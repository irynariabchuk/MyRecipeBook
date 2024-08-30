//
//  Endpoint.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import Foundation

// MARK: - Endpoint
enum Endpoint {
    case meals(String)
    case mealDetails(String)
    
    var path: String {
        switch self {
        case .meals(let category):
            return "/filter.php?c=\(category)"
        case .mealDetails(let mealId):
            return "/lookup.php?i=\(mealId)"
        }
    }
    
    var url: URL? {
        return URL(string: APIConstants.baseURL + path)
    }
}
