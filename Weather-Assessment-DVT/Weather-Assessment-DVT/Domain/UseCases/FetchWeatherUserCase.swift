//
//  FetchWeatherUserCase.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//

import Foundation

protocol FetchWeatherUserCaseProtocol {
    func execute(lat: String?, lon: String?) async throws -> WeatherResponseDTO
}

struct FetchWeatherUserCase: FetchWeatherUserCaseProtocol {
   
    private let repository: FetchWeatherRepository
    
    init(repository: FetchWeatherRepository = FetchWeatherRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(lat: String?, lon: String?) async throws -> WeatherResponseDTO {
        try await repository.fetchWeather(lat: lat, lon: lon)
    }
}
