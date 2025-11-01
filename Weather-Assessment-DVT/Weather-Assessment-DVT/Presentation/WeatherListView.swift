//
//  WeatherListView.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//

import SwiftUI

struct WeatherListView: View {
    
    @ObservedObject var viewModel: WeatherDashboardViewModel
    
    init(viewModel: WeatherDashboardViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading forecast...")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else {
                List(viewModel.forecastDailyList, id: \.self) { item in
                    WeatherRowView()
                        .listRowSeparator(.hidden)
                        .padding(.vertical, 8)
                        .listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}

//#Preview {
//    WeatherListView()
//}
