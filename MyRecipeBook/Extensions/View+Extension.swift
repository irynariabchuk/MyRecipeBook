//
//  View+Extension.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 28.08.2024.
//

import SwiftUI

extension View {
    
    func errorAlert(isPresented: Binding<Bool>, errorMessage: String?) -> some View {
        alert(isPresented: isPresented) {
            Alert(
                title: Text("Error"),
                message: Text(errorMessage ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
