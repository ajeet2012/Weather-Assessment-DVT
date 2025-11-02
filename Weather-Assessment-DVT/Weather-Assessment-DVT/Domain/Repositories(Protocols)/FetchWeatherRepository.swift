//
//  FetchWeatherRepository.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//

import Foundation

protocol FetchWeatherRepository {
    func fetchWeather(lat: String?, lon: String?) async throws -> WeatherResponseDTO
}
