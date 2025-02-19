//
//  MealDetailsNetworkService.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import Foundation

protocol MealDetailsNetworkServiceProtocol {
    func fetchMealDetails(_ mealId: String) async throws -> MealDetails?
}

// MARK: - MealDetailsNetworkService
final class MealDetailsNetworkService: MealDetailsNetworkServiceProtocol {
    
    // MARK: - Private Properties
    private let networkManager: NetworkManagerProtocol
    
    // MARK: - Init
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    // MARK: - Public Methods
    func fetchMealDetails(_ mealId: String) async throws -> MealDetails? {
        guard let url = Endpoint.mealDetails(mealId).url else {
            throw NetworkError.urlError(URLError(.badURL))
        }
        
        let mealsResponse: MealDetailsResponse = try await networkManager.request(
            url: url,
            method: .get,
            headers: nil,
            body: nil,
            responseType: MealDetailsResponse.self
        )

        return mealsResponse.meals.first
    }
}

