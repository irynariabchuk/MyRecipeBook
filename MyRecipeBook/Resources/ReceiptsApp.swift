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
    private let networkManager = NetworkManager()
    private var viewModel: MealsListViewModel

    // MARK: - Init
    init() {
        viewModel = MealsListViewModel(networkManager: networkManager)
    }
    
    // MARK: - Views
    var body: some Scene {
        WindowGroup {
            MealsListView(viewModel: viewModel)
        }
    }
}
