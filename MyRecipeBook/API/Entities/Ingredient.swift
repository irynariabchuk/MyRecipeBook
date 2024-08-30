//
//  Ingredient.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 28.08.2024.
//

import Foundation

// MARK: - Ingredient
struct Ingredient: Codable, Identifiable {
    
    var id = UUID()
    let name: String
    let measure: String
}
