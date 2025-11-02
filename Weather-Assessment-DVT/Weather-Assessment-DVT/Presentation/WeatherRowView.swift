//
//  WeatherRowView.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//

import SwiftUI

struct WeatherRowView: View {
    @Binding var forcastItem: ForecastItem
    var body: some View {
        VStack(spacing: 0) {
            Text(forcastItem.dt_txt.dayFromDateString() ?? "")
                .font(.custom("Poppins-Bold", size: 24))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            HStack {
                Image(forcastItem.weather[0].main.weatherIconName())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                Spacer()
                Text(forcastItem.main.temp.description)
                    .font(.custom("Poppins-Medium", size: 45))
                    .fontWeight(.semibold)
            }
            .padding(.horizontal)
        }
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemBackground)) // background color
        )
    }
}

//#Preview {
//    WeatherRowView()
//}
