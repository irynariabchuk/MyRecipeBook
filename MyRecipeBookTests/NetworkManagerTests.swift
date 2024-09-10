//
//  MyRecipeBookTests.swift
//  MyRecipeBookTests
//
//  Created by Iryna Riabchuk on 9/10/24.
//

import XCTest
@testable import MyRecipeBook

// MARK: - NetworkManagerTests
final class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!
    var urlSessionMock: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        urlSessionMock = URLSessionMock()
        networkManager = NetworkManager(session: urlSessionMock)
    }
    
    override func tearDown() {
        urlSessionMock = nil
        networkManager = nil
        super.tearDown()
    }
    
    // Test case for successful request with valid MealsResponse data
    func testRequest_Success_MealsResponse() async throws {
        // Given
        let expectedData = """
        {
            "meals": [
                {
                    "idMeal": "1245",
                    "strMeal": "Test Meal",
                    "strMealThumb": "https://www.themealdb.com/images/media/meals/1245.jpg"
                }
            ]
        }
        """.data(using: .utf8)!
        urlSessionMock.mockData = expectedData
        let url = URL(string: "https://example.com/meals")!
        
        // When
        let result: MealsResponse = try await networkManager.request(url: url, responseType: MealsResponse.self)
        
        // Then
        XCTAssertEqual(result.meals.count, 1)
        XCTAssertEqual(result.meals.first?.id, "1245")
        XCTAssertEqual(result.meals.first?.title, "Test Meal")
        XCTAssertEqual(result.meals.first?.url?.absoluteString, "https://www.themealdb.com/images/media/meals/1245.jpg")
    }
}

// MARK: - URLSessionMock
final class URLSessionMock: URLSessionProtocol {
    
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        let data = mockData ?? Data()
        let response = mockResponse ?? HTTPURLResponse(
            url: request.url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        return (data, response)
    }
}
