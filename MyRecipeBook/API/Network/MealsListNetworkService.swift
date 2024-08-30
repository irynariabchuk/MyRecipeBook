//
//  MealsListNetworkService.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import Foundation

// MARK: - MealsListNetworkService
final class MealsListNetworkService {
    
    // MARK: - Singleton
    static let shared = MealsListNetworkService()
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    
    // MARK: - Public Methods
    func fetchMeals(by filter: String) async throws -> [Meal] {
        guard let url = Endpoint.meals(filter).url else {
            throw URLError(.badURL)
        }
        
        let mealsResponse: MealsResponse = try await networkManager.request(
            url: url,
            responseType: MealsResponse.self
        )

        return mealsResponse.meals
    }
}
