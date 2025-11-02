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

// MARK: - Network Query Type
enum NetworkQueryType {
    case path([String: String]) // parameters in URL query
    case json([String: Any])    // parameters in JSON body
    case none
}


// MARK: - Requestable Protocol
protocol Requestable {
    var endpoint: String { get } // endpoint path, e.g., "/data/2.5/forecast"
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryType: NetworkQueryType { get }
}

// MARK: - Network Manager
class NetworkManager {
    
    static let shared = NetworkManager() // singleton
    private let baseURL = "https://api.openweathermap.org"
    private init() {}
    
    // Generic async request method
    func request<T: Decodable>(_ requestable: Requestable) async throws -> T {
        var urlString = baseURL + requestable.endpoint
        var bodyData: Data? = nil
        
        switch requestable.queryType {
        case .path(let params):
            if var urlComponents = URLComponents(string: urlString) {
                urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
                guard let fullURL = urlComponents.url else { throw NetworkError.invalidURL }
                urlString = fullURL.absoluteString
            }
        case .json(let params):
            bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
        case .none:
            break
        }
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        print("url - \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = requestable.method.rawValue
        request.allHTTPHeaderFields = requestable.headers
        request.httpBody = bodyData
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

