//
//  NetworkManager.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//

import Foundation

// MARK: - HTTP Method Enum
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// MARK: - Network Error Enum with code and description
enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse(statusCode: Int)
    case decodingFailed(Error)
    case unknown
    
    var description: String {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .requestFailed(let error):
            return "The request failed with error: \(error.localizedDescription)"
        case .invalidResponse(let statusCode):
            return "Invalid response from server. Status code: \(statusCode)"
        case .decodingFailed(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .unknown:
            return "An unknown error occurred."
        }
    }
}


// MARK: - Requestable Protocol
protocol Requestable {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var responseType: Decodable.Type { get }
}

// MARK: - Network Manager
class NetworkManager {
    
    static let shared = NetworkManager() // singleton
    private let baseUrlString = "https://api.openweathermap.org"
    private init() {}
    
    // Generic async request method
    func request<T: Decodable>(_ requestable: Requestable) async throws -> T {
        guard let url = URL(string: requestable.path) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestable.method.rawValue
        request.allHTTPHeaderFields = requestable.headers
        
//        if let parameters = requestable.parameters {
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
//                request.httpBody = jsonData
//            } catch {
//                print("Error encoding parameters: \(error)")
//            }
//        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.invalidResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                throw NetworkError.decodingFailed(error)
            }
            
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}

