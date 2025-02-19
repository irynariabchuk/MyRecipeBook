//
//  DependencyContainer.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 18.02.2025.
//

import Foundation

// MARK: - DependencyContainer + ServiceContainerProtocol
final class DependencyContainer: ServiceContainerProtocol {
    
    // MARK: - Private Properties
    private lazy var networkManager: NetworkManagerProtocol = NetworkManager()
    
    // MARK: - Services
    lazy var mealsListNetworkService: MealsListNetworkServiceProtocol = MealsListNetworkService(networkManager: networkManager)
    lazy var mealDetailsNetworkService: MealDetailsNetworkServiceProtocol = MealDetailsNetworkService(networkManager: networkManager)
}
