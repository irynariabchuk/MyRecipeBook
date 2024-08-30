//
//  NetworkManager.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import Foundation

// MARK: - NetworkManager
final class NetworkManager {
    
    // MARK: - Singleton Instance
    static let shared = NetworkManager()
    
    // MARK: - Public Methods
    func request<T: Decodable>(
        url: URL,
        method: HTTPMethod = .get,
        headers: [String: String]? = nil,
        body: Data? = nil,
        responseType: T.Type
    ) async throws -> T {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if method.allowsBody {
            request.httpBody = body
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            try validateResponse(response)
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw handleNetworkError(error)
        }
    }
}

private extension NetworkManager {
    
    func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.statusCode(httpResponse.statusCode)
        }
    }
    
    func handleNetworkError(_ error: Error) -> NetworkError {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return .noInternet
            case .timedOut:
                return .timeout
            default:
                return .urlError(urlError)
            }
        } else if let decodingError = error as? DecodingError {
            return .decodingError(decodingError)
        } else {
            return .unknown(error.localizedDescription)
        }
    }
}
