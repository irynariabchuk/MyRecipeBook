//
//  MealsListNetworkService.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import Foundation

// MARK: - MealsListNetworkService
final class MealsListNetworkService {
    
    // MARK: - Private Properties
    private let networkManager: NetworkManager
    
    // MARK: - Initialization
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
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
