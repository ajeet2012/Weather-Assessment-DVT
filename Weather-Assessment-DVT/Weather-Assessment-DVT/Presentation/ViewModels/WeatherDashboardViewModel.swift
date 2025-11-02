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
    @Published var forecastList: [ForecastItem] = []
    
    private let weatherUseCase: FetchWeatherUserCaseProtocol
    
    let strings: StringsConsts = .init()
    
    init(weatherUserCase: FetchWeatherUserCaseProtocol = FetchWeatherUserCase()){
        self.weatherUseCase = weatherUserCase
    }
    
    
    func fetchForecast(for latitude: Double, longitude: Double) async {
        isLoading = true
        print(latitude)
        print(longitude)
        do {
            let forecastDailyList = try await weatherUseCase.execute(lat: "\(latitude)", lon: "\(longitude)", units: .metric)
            self.forecastList = self.fetchOneEntryForEachDay(fullList: forecastDailyList.list)
            self.isLoading = false
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
        
    }
    
    private func fetchOneEntryForEachDay(fullList: [ForecastItem]) -> [ForecastItem] {
        var firstFiveDays: [String: ForecastItem] = [:]
        
        for item in fullList {
            let datePart = String(item.dt_txt.prefix(10))
            
            // Keep only the first entry per date
            if firstFiveDays[datePart] == nil {
                firstFiveDays[datePart] = item
            }
        }
        
        // Convert to array sorted by date
        return firstFiveDays.values.sorted { $0.dt_txt < $1.dt_txt }
    }
    
}

extension WeatherDashboardViewModel {
    struct StringsConsts {
        static let headerTitle: String = "5 day Forecast"
    }
}
