//
//  MealDetailsView.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import SwiftUI
import SDWebImageSwiftUI

// MARK: - MealDetailsView
struct MealDetailsView: View {
    
    // MARK: - Public Properties
    @ObservedObject var viewModel: MealDetailsViewModel
    
    // MARK: - Private Properties
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Views
    var body: some View {
        contentView
            .navigationBarHidden(true)
            .background(Color.primaryBackgroundColor)
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
            .task {
                await viewModel.fetchMealDetails()
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
    var contentView: some View {
        ZStack(alignment: .topLeading) {
            scrollView
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.primaryTextColor)
                    .padding()
                    .background(Color.secondaryBackgroundColor.opacity(0.6))
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
            .padding(.leading, 16)
        }
    }
    
    @ViewBuilder
    var scrollView: some View {
        ScrollView {
            VStack(spacing: -50) {
                imageView
                if viewModel.state.isLoading == false {
                    contentDetails
                }
            }
        }
        .background(Color.primaryBackgroundColor)
    }
    
    @ViewBuilder
    var contentDetails: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(viewModel.title)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.primaryTextColor)
            Text(viewModel.instructions)
                .font(.system(size: 16))
                .foregroundStyle(Color.secondaryTextColor)
            Text("Ingredients")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.primaryTextColor)
            ingredientsList
        }
        .padding(UIDevice.current.userInterfaceIdiom == .phone ? 16 : 40)
        .background(Color.secondaryBackgroundColor)
        .cornerRadius(16)
        .frame(minHeight: 200)
        .shadow(radius: 10)
        .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .phone ? 16 : 40)
    }
    
    @ViewBuilder
    var ingredientsList: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(viewModel.ingredients) { ingredient in
                HStack {
                    Text(ingredient.name)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.primaryTextColor)
                    Spacer()
                    Text(ingredient.measure)
                        .font(.system(size: 16))
                        .foregroundStyle(.gray)
                }
                Divider()
            }
        }
    }
    
    @ViewBuilder
    var imageView: some View {
        WebImage(url: viewModel.imageUrl) {
            $0.resizable()
        } placeholder: {
            ZStack {
                Image("placeholder")
                    .resizable()
                    .foregroundStyle(Color.secondaryText)
            }
        }
        .stretchy()
        .frame(height: viewModel.dynamicImageHeight)
    }
}

// MARK: - Preview
#Preview {
    MealDetailsView(viewModel: MealDetailsViewModel(id: "52772"))
}
