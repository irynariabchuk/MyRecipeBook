//
//  NetworkError.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 29.08.2024.
//

import Foundation

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidResponse
    case statusCode(Int)
    case noInternet
    case timeout
    case decodingError(DecodingError)
    case urlError(URLError)
    case unknown(String)
}
