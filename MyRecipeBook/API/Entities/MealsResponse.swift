//
//  MealsResponse.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import Foundation

// MARK: - MealsResponse
struct MealsResponse: Codable {
    let meals: [Meal]
}

// MARK: - Meal
struct Meal: Codable, Identifiable {
    
    let id: String
    let title: String?
    let urlString: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case title = "strMeal"
        case urlString = "strMealThumb"
    }
}

extension Meal {
    
    var url: URL? {
        guard let urlString else {
            return nil
        }
        
        return URL(string: urlString)
    }
}
