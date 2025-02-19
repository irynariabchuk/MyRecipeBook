//
//  NetworkManager.swift
//  MyRecipeBook
//
//  Created by Iryna Riabchuk on 8/27/24.
//

import Foundation

// MARK: - URLSessionProtocol
protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

// MARK: - URLSession + URLSessionProtocol
extension URLSession: URLSessionProtocol {}

// MARK: - NetworkManagerProtocol
protocol NetworkManagerProtocol {
    func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]?,
        body: Data?,
        responseType: T.Type
    ) async throws -> T
}

// MARK: - NetworkManager
final class NetworkManager: NetworkManagerProtocol {
    
    private let session: URLSessionProtocol
    private let decoder: JSONDecoder
    
    // MARK: - Init
    init(
        session: URLSessionProtocol = URLSession.shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }
    
    // MARK: - Public Methods
    /// Performs a network request and decodes the response into the specified type.
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
            let (data, response) = try await session.data(for: request)
            try validateResponse(response, data: data)
            return try decodeResponse(data: data, responseType: responseType)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw handleError(error)
        }
    }
}

// MARK: - Private Methods
private extension NetworkManager {
    
    /// Validates the HTTP response and attempts to decode server errors if the status code is invalid.
    func validateResponse(_ response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        if !(200...299).contains(httpResponse.statusCode) {
            if let serverError = try? decoder.decode(ErrorMainResponse.self, from: data) {
                throw NetworkError.serverError(serverError.error)
            }
            
            throw NetworkError.statusCode(httpResponse.statusCode)
        }
    }
    
    /// Decodes a successful response into the specified type.
    func decodeResponse<T: Decodable>(data: Data, responseType: T.Type) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            throw NetworkError.decodingError(decodingError)
        } catch {
            throw NetworkError.unknown(error.localizedDescription)
        }
    }
    
    /// Handles general errors, such as `URLError` or unknown errors.
    func handleError(_ error: Error) -> NetworkError {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return .noInternet
            case .timedOut:
                return .timeout
            default:
                return .urlError(urlError)
            }
        }
        
        return .unknown(error.localizedDescription)
    }
}
