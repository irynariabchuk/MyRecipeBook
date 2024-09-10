//
//  MealDetailsNetworkService.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import Foundation

// MARK: - MealDetailsNetworkService
final class MealDetailsNetworkService {
    
    // MARK: - Private Properties
    private let networkManager: NetworkManager
    
    // MARK: - Initialization
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    // MARK: - Public Methods
    func fetchMealDetails(_ mealId: String) async throws -> MealDetails? {
        guard let url = Endpoint.mealDetails(mealId).url else {
            throw URLError(.badURL)
        }
        
        let mealsResponse: MealDetailsResponse = try await networkManager.request(
            url: url,
            responseType: MealDetailsResponse.self
        )

        return mealsResponse.meals.first
    }
}

