//
//  ReceiptsApp.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 28.08.2024.
//

import SwiftUI

@main
struct ReceiptsApp: App {
    
    // MARK: - Private Properties
    private let container = DependencyContainer()
    
    // MARK: - Views
    var body: some Scene {
        let viewModel = MealsListViewModel(serviceContainer: container)
        
        WindowGroup {
            MealsListView(viewModel: viewModel)
        }
    }
}
