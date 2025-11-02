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
                Image("Property 1=01.sun-light")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                Spacer()
                Text("28°")
                    .font(.custom("Poppins-Medium", size: 50))
                    .fontWeight(.semibold)
            }
            .padding(.horizontal)
        }
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.white)) // background color
        )
    }
}

//#Preview {
//    WeatherRowView()
//}
