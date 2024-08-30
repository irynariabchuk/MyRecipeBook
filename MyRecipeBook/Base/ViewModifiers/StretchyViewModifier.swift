//
//  StretchyViewModifier.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 29.08.2024.
//

import SwiftUI

// MARK: - Stretchy
struct StretchyViewModifier: ViewModifier {
    
    // MARK: - Public Methods
    func body(content: Content) -> some View {
        GeometryReader { reader in
            Color.clear
                .overlay(content.aspectRatio(contentMode: .fill))
                .clipShape(.rect(cornerRadius: 20))
                .frame(height: heightFor(reader))
                .offset(y: offsetFor(reader))
        }
    }
    
    // MARK: - Private Methods
    private func heightFor(_ reader: GeometryProxy) -> CGFloat {
        let height = reader.size.height
        let frame = reader.frame(in: .global)
        return height + max(0, frame.minY)
    }
    
    private func offsetFor(_ reader: GeometryProxy) -> CGFloat {
        let frame = reader.frame(in: .global)
        return min(0, -frame.minY)
    }
}

extension View {
    
    func stretchy() -> some View {
        modifier(StretchyViewModifier())
    }
}
