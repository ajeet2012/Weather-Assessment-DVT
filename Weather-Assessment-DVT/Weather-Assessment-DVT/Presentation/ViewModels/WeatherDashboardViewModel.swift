//
//  WeatherDashboardViewModel.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//

import Foundation

@MainActor
class WeatherDashboardViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var forecastDailyList: [String] = ["Day 1", "Day 2", "Day 3"]
    
    private let weatherUseCase: FetchWeatherUserCaseProtocol
    
    init(weatherUserCase: FetchWeatherUserCaseProtocol = FetchWeatherUserCase()){
        self.weatherUseCase = weatherUserCase
    }
    
    
    func fetchForecast(for latitude: Double, longitude: Double) async {
        isLoading = true
        print(latitude)
        print(longitude)
        do {
            let forecastDailyList = try await weatherUseCase.execute(lat: "\(latitude)", lon: "\(longitude)")
            //self.forecastDailyList = forecastDailyList
            print("\(forecastDailyList.list.count)")
            self.isLoading = false
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
        
        
    }
    
}
