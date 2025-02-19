//
//  ErrorMain.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 18.02.2025.
//

import Foundation

// MARK: - ErrormainResponse
struct ErrorMainResponse: Decodable {
    let error: ErrorMain
}

// MARK: - ErrorMain
struct ErrorMain: Error, Decodable {
    let code: Int
    let message: String
}
