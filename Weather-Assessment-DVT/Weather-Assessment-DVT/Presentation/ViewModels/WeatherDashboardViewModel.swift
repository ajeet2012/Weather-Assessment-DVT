//
//  WeatherDashboardViewModel.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//

import Foundation
@MainActor
class WeatherDashboardViewModel: ObservableObject {
    
    
    func fetchForecast(for latitude: Double, longitude: Double) async {
        debugPrint("longitude: \(longitude), latitude: \(latitude)")
        
    }
    
}
