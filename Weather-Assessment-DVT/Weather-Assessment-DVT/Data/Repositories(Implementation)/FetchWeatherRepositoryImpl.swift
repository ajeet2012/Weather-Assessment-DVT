//
//  FetchWeatherRepositoryImpl.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//

import Foundation

class FetchWeatherRepositoryImpl: FetchWeatherRepository {
    
    
    private let dataSource: WeatherDataSource
    
    init(dataSource: WeatherDataSource = Constants.isSandboxMode ? MockWeatherDataSource() : RemoteWeatherDataSource()) {
        self.dataSource = dataSource
    }
    
    func fetchWeather(lat: String?, lon: String?, units: Units? = .metric) async throws -> WeatherResponseDTO {
        try await dataSource.fetchWeatherData(request: .init(lat: lat, lon: lon, appid: Constants.apiKey))        
    }
 
}
