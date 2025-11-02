//
//  WeatherDataSource.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//

import Foundation

protocol WeatherDataSource {
    func fetchWeatherData(request: WeatherRequest) async throws -> WeatherResponseDTO
}

class RemoteWeatherDataSource: WeatherDataSource {
    func fetchWeatherData(request: WeatherRequest) async throws -> WeatherResponseDTO {
        try await NetworkManager.shared.request(request)
    }
}

class MockWeatherDataSource: WeatherDataSource {
    func fetchWeatherData(request: WeatherRequest) async throws -> WeatherResponseDTO {
        try await Task.sleep(nanoseconds: 100000000)
        guard let url = Bundle.main.url(forResource: "mock_weather_response", withExtension: "json") else {
            throw NSError(domain: "FileNotFound", code: 404, userInfo: nil)
        }
        let data = try Data(contentsOf: url)
        let weatherResponse = try JSONDecoder().decode(WeatherResponseDTO.self, from: data)
        return weatherResponse
    }
}
