//
//  MealsViewModel.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import Foundation

// MARK: - MealsViewModel
final class MealsViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var meals: [Meal] = []
    
    // MARK: - State
    @Published var state: MealsListState = .idle
    
    // MARK: - Public Methods
    @MainActor
    func fetchMeals(_ filter: String = "Dessert") {
        state = .loading
        
        Task {
            do {
                let fetchedMeals = try await MealsListNetworkService.shared.fetchMeals(by: filter)
                meals = sortMeals(fetchedMeals)
                state = .idle
            } catch {
                state = .error("Failed to fetch meals: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Private Methods
    private func sortMeals(_ meals: [Meal]) -> [Meal] {
        return meals.sorted {
            ($0.title ?? "") < ($1.title ?? "")
        }
    }
}
