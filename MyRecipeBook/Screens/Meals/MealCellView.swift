//
//  MealCellView.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import SwiftUI
import SDWebImageSwiftUI

// MARK: - MealCellView
struct MealCellView: View {
    
    // MARK: - Public Properties
    var model: Meal
    
    // MARK: - Views
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            imageView
            Text(model.title ?? "N/A")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.primaryTextColor)
                .frame(alignment: .leading)
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    var imageView: some View {
        WebImage(url: model.url) {
            $0.resizable()
            .scaledToFill()
        } placeholder: {
            ZStack {
                Image("placeholder")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(Color.secondaryText)
            }
        }
        .frame(height: CGFloat(160).scalableHeight)
        .clipped()
        .cornerRadius(10)
    }
}
