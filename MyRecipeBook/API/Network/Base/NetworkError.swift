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
    case serverError(ErrorMain)
    case urlError(URLError)
    case unknown(String)
}

// MARK: - NetworkError + LocalizedError
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .serverError(let error):
            return LocalizedStrings.serverError.localizeWithFormat(arguments: "\(error.message)", "\(error.code)")
        case .noInternet:
            return LocalizedStrings.noInternetConnection
        case .timeout:
            return LocalizedStrings.timeoutError
        case .statusCode(let code):
            return LocalizedStrings.httpError.localizeWithFormat(arguments: "\(code)")
        case .invalidResponse:
            return LocalizedStrings.invalidResponse
        case .decodingError(let decodingError):
            return LocalizedStrings.decodingError.localizeWithFormat(arguments: "\(decodingError.localizedDescription)")
        case .urlError(let urlError):
            return LocalizedStrings.urlError.localizeWithFormat(arguments: "\(urlError.localizedDescription)")
        case .unknown(let message):
            return LocalizedStrings.unknownError.localizeWithFormat(arguments: "\(message)")
        }
    }
}
