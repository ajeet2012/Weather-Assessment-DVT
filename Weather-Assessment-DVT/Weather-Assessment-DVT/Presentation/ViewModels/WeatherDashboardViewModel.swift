//
//  WeatherDashboardViewModel.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//

import Foundation

@MainActor
class WeatherDashboardViewModel: ObservableObject {
    
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    @Published var forecastDailyList: [String] = ["Day 1", "Day 2", "Day 3"]
    
    func fetchForecast(for latitude: Double, longitude: Double) async {
        debugPrint("longitude: \(longitude), latitude: \(latitude)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isLoading = false
        }
    }
    
}
