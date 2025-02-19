//
//  MealsListViewModel.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import Foundation

// MARK: - MealsViewModel
final class MealsListViewModel: ObservableObject {
    
    // MARK: - Public Properties
    let serviceContainer: ServiceContainerProtocol
    
    // MARK: - Published Properties
    @Published var meals: [Meal] = []
    
    // MARK: - State
    @Published var state: MealsListState = .idle
    
    // MARK: - Init
    init(serviceContainer: ServiceContainerProtocol) {
        self.serviceContainer = serviceContainer
    }
    
    // MARK: - Public Methods
    @MainActor
    func fetchMeals(_ filter: String = "Dessert") async {
        state = .loading
        
        do {
            let fetchedMeals = try await serviceContainer.mealsListNetworkService.fetchData(by: filter)
            meals = sortMeals(fetchedMeals)
            state = .idle
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    // MARK: - Private Methods
    private func sortMeals(_ meals: [Meal]) -> [Meal] {
        return meals.sorted {
            ($0.title ?? "") < ($1.title ?? "")
        }
    }
}
