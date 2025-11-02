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
                HStack{
                    Text(WeatherDashboardViewModel.StringsConsts.headerTitle)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    Spacer()
                    Text("\(weatherLocationManager.city), \(weatherLocationManager.country)")
                        .font(.system(size: 15, weight: .bold, design: .default))
                        .padding(.trailing)
                }
                .padding(.top, 50)
                Divider()
                    .background(.primary)
                        .frame(height: 2)
                
                Spacer()
                WeatherListView(viewModel: viewModel)
                    .padding(.bottom)
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


