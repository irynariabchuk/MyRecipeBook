//
//  MealsListView.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import SwiftUI

// MARK: - MealsListView
struct MealsListView: View {
    
    // MARK: - Private Properties
    @ObservedObject private var viewModel = MealsViewModel()
    
    private let gridLayout: [GridItem] = Array(
        repeating: GridItem(.flexible(), spacing: 0),
        count: UIDevice.current.userInterfaceIdiom == .phone ? 1 : 2
    )
    
    // MARK: - Views
    var body: some View {
        NavigationView {
            scrollView
                .navigationTitle("Receipts")
                .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .task {
            viewModel.fetchMeals()
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
    }
    
    @ViewBuilder
    var scrollView: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 20) {
                ForEach(viewModel.meals) { meal in
                    NavigationLink(destination: MealDetailsView(viewModel: MealDetailsViewModel(id: meal.id))) {
                        MealCellView(model: meal)
                    }
                }
            }
            .padding(.top)
        }
        .background(Color.primaryBackgroundColor)
    }
}

// MARK: - Preview
#Preview {
    MealsListView()
}
