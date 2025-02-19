//
//  MealsListNetworkService.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import Foundation

// MARK: - ExampleNetworkServiceProtocol
protocol MealsListNetworkServiceProtocol {
    func fetchData(by searchText: String) async throws -> [Meal]
}

// MARK: - MealsListNetworkService
final class MealsListNetworkService: MealsListNetworkServiceProtocol {
 
    // MARK: - Private Properties
    private let networkManager: NetworkManagerProtocol
    
    // MARK: - Init
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    // MARK: - Public Methods
    func fetchData(by searchText: String) async throws -> [Meal] {
        guard let url = Endpoint.meals(searchText).url else {
            throw NetworkError.urlError(URLError(.badURL))
        }
        
        let response: MealsResponse = try await networkManager.request(
            url: url,
            method: .get,
            headers: nil,
            body: nil,
            responseType: MealsResponse.self
        )
        return response.meals
    }
}
