//
//  Extensions.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//

import Foundation

extension String {
    
    func dayFromDateString() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = formatter.date(from: self) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            let dayName = dayFormatter.string(from: date)
            return dayName
        }
        
        return nil
    }
    
    
    func weatherIconName() -> String {
        switch self.lowercased() {
        case "thunderstorm":
            return "Property 1=13.thunderstorm-light"
        case "drizzle":
            return "Property 1=24.drop-light"
        case "rain":
            return "Property 1=20.rain-light"
        case "snow":
            return "Property 1=22.snow-light"
        case "mist":
            return "Property 1=06.rainyday-light"
        case "smoke":
            return "Property 1=21.heavy-wind-light"
        case "haze":
            return "Property 1=15.cloud-light"
        case "dust":
            return "Property 1=21.heavy-wind-light"
        case "fog":
            return "Property 1=07.mostly-cloud-light"
        case "sand":
            return "Property 1=21.heavy-wind-light"
        case "ash":
            return "Property 1=14.heavy-snowfall-light"
        case "squall":
            return "Property 1=21.heavy-wind-light"
        case "tornado":
            return "Property 1=21.heavy-wind-light"
        case "clear":
            return "Property 1=01.sun-light"
        case "clouds":
            return "Property 1=11.mostly-cloudy-light"
        default:
            return "Property 1=05.partial-cloudy-light" // fallback for unknown
        }
    }

    
}
