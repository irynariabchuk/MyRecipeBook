//
//  ServiceContainer.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 18.02.2025.
//

import Foundation

protocol ServiceContainerProtocol {
    var mealsListNetworkService: MealsListNetworkServiceProtocol { get }
    var mealDetailsNetworkService: MealDetailsNetworkServiceProtocol { get }
}
