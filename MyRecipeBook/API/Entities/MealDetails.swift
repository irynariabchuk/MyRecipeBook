//
//  MealDetails.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import Foundation

// MARK: - MealDetailsResponse
struct MealDetailsResponse: Codable {
    let meals: [MealDetails]
}

// MARK: - MealDetails
struct MealDetails: Codable {
    
    let id: String
    let title: String?
    let instructions: String?
    let urlString: String?
    let ingredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case title = "strMeal"
        case instructions = "strInstructions"
        case urlString = "strMealThumb"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        instructions = try container.decode(String.self, forKey: .instructions)
        urlString = try container.decodeIfPresent(String.self, forKey: .urlString)
        
        // Decode ingredients from JSON. Using `AnyCodingKey` for dynamic key creation
        // as the number of ingredients is unknown beforehand.
        let ingredientContainer = try decoder.container(keyedBy: AnyCodingKey.self)
        var ingredientsArray = [Ingredient]()
        
        // Iterate through potential ingredient and measure indices (e.g., "strIngredient1", "strMeasure1").
        for key in ingredientContainer.allKeys {
            if key.stringValue.starts(with: "strIngredient"),
               let ingredient = try ingredientContainer.decodeIfPresent(String.self, forKey: key),
               !ingredient.isEmpty {
                
                let index = key.stringValue.dropFirst("strIngredient".count)
                let measureKey = AnyCodingKey(stringValue: "strMeasure\(index)")
                let measure = (try? ingredientContainer.decodeIfPresent(String.self, forKey: measureKey)) ?? ""
                
                ingredientsArray.append(Ingredient(name: ingredient, measure: measure))
            }
        }
        
        ingredients = ingredientsArray
    }
}

extension MealDetails {
    
    var url: URL? {
        guard let urlString else {
            return nil
        }
        return URL(string: urlString)
    }
}
