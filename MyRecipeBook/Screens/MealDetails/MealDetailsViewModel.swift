//
//  MealDetailsViewModel.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import SwiftUI

// MARK: - MealDetailsViewModel
final class MealDetailsViewModel: ObservableObject {
    
    // MARK: - Public Properties
    let dynamicImageHeight: CGFloat = CGFloat(200).scalableHeight
    
    // MARK: - Published Properties
    @Published var title: String = ""
    @Published var imageUrl: URL?
    @Published var instructions: String = ""
    @Published var ingredients: [Ingredient] = []

    // MARK: - State
    @Published var state: MealDetailsState = .idle

    // MARK: - Private Properties
    private var mealId: String
    
    // MARK: - Init
    init(id: String) {
        mealId = id
    }
    
    // MARK: - Public Methods
    @MainActor
    func fetchMealDetails() async {
        state = .loading
        
        do {
            if let fetchedMealDetails = try await MealDetailsNetworkService.shared.fetchMealDetails(mealId) {
                configureMealValues(meal: fetchedMealDetails)
                state = .idle
            } else {
                state = .error("No meal details found.")
            }
        } catch {
            state = .error("Failed to fetch meal details: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Private Methods
    private func configureMealValues(meal: MealDetails) {
        title = meal.title ?? ""
        imageUrl = meal.url
        instructions = meal.instructions ?? ""
        ingredients = meal.ingredients
    }
}
