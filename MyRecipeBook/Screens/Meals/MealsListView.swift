//
//  MealsListView.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import SwiftUI

// MARK: - MealsListView
struct MealsListView: View {
    
    // MARK: - Public Properties
    @ObservedObject var viewModel: MealsListViewModel
    
    // MARK: - Private Properties
    private let gridLayout: [GridItem] = Array(
        repeating: GridItem(.flexible(), spacing: 0),
        count: UIDevice.current.userInterfaceIdiom == .phone ? 1 : 2
    )
    
    // MARK: - Views
    var body: some View {
        NavigationStack {
            scrollView
                .navigationTitle("Receipts")
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(.stack)
                .task {
                    await viewModel.fetchMeals()
                }
                .errorAlert(
                    isPresented: .constant(viewModel.state.isError),
                    errorMessage: viewModel.state.error
                )
                .overlay {
                    if viewModel.state.isLoading {
                        ProgressView()
                    }
                }
                .navigationDestination(for: String.self) { mealID in
                    MealDetailsView(
                        viewModel: MealDetailsViewModel(id: mealID, serviceContainer: viewModel.serviceContainer)
                    )
                }
        }
    }
    
    @ViewBuilder
    private var scrollView: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 20) {
                ForEach(viewModel.meals) { meal in
                    NavigationLink(value: meal.id) {
                        MealCellView(model: meal)
                    }
                }
            }
            .padding(.top)
        }
    }
}
