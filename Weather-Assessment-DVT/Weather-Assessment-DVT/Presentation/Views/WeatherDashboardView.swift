//
//  WeatherDashboardView.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//

import SwiftUI

struct WeatherDashboardView: View {
    @State private var cityName: String = ""
    @StateObject private var viewModel: WeatherDashboardViewModel = .init()
    @StateObject private var weatherLocationManager: WeatherLocationManager = .init()
    
    var body: some View {
        
        ZStack {
            Image("Cloudy")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("\(weatherLocationManager.city), \(weatherLocationManager.country)")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 50)
                    .padding(.horizontal)
                Spacer()
                WeatherListView(viewModel: viewModel)
                Spacer()
            }
            .onAppear {
                weatherLocationManager.requestForLocation()
            }
            .onReceive(weatherLocationManager.$currentLocation) { location in
                guard let location = location else { return }
                Task {
                    await viewModel.fetchForecast(for: location.coordinate.latitude, longitude: location.coordinate.longitude)
                }
                
            }
        }
        
    }
}

#Preview {
    WeatherDashboardView()
}


